# Kubernetes Helm Charts

> Inspired by
> [https://charts.mcswain.dev/](https://charts.mcswain.dev/)

The code is provided as is without warrenties to others or myself.

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add demeesterdev https://charts.demeester.dev
```

You can then run `helm search repo demeesterdev` to see the charts.

## Chart Overview

| Chart | Description |
| ----- | ----------- |
| [container-app](charts/container-app/) | A Helm chart for a generic Docker app |
