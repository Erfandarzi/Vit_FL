import torch

from medscale.core.aggregators import ClientsAvgAggregator
from medscale.core.auxiliaries.optimizer_builder import get_optimizer


class FedOptAggregator(ClientsAvgAggregator):
    """
    Implementation of FedOpt refer to `Adaptive Federated Optimization` \
    [Reddi et al., 2021](https://openreview.net/forum?id=LkFG3lB13U5)
    """
    def __init__(self, config, model, device='cpu'):
        super(FedOptAggregator, self).__init__(model, device, config)
        self.optimizer = get_optimizer(model=self.model,
                                       **config.fedopt.optimizer)

    def aggregate(self, agg_info):
        """
        To preform FedOpt aggregation.
        """
        new_model = super().aggregate(agg_info)

        model = self.model.cpu().state_dict()
        with torch.no_grad():
            grads = {key: model[key] - new_model[key] for key in new_model}

        self.optimizer.zero_grad()
        for key, p in self.model.named_parameters():
            if key in new_model.keys():
                p.grad = grads[key]
        self.optimizer.step()

        return self.model.state_dict()
