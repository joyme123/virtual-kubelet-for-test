# virtual kubelet for test

部署 virtual kubelet：
```yaml
kubectl apply -f k8s.yaml
```

查看 node，会发现多出一个 virtual node.
```yaml
kubectl get nodes

# virtual-node-85c77699f9-pqfj2   Ready    agent                  5s    v1.15.2-vk-v1.6.0-4-g410e0587-dev
```

通过伸缩 pod 副本数可以增删 node

```yaml
kubectl scale deployment virtual-node --replicas=2
```

使用场景：写一些 controller 的时候可能需要频繁的增删 node 来触发事件做测试。可以通过这种方式实现。

## 原理说明

virtual-kubelet 顾名思义，是一个虚拟的 kubelet 实现，一般用来实现将 pod 调度到非 k8s 集群的外部系统上。比如一些 Serverless。

virtual-kubelet 本身提供了一个 mock provider，简单实现了一些必要的方法。这里复用了 virtual-kubelet 的 mock 实现并做了简单的改动。并且当 pod 删除时，会调用 PreStop hook，调用 kubelet 把自己所代表的 node 删除。