# 深入了解 kube-scheduler
## kube-scheduler 用途
kube-scheduler 主要用途是负责将 Pod 调度到 Node 上。
![k8s-pod-create-flow](../../image/Kubernetes/resource_code_learning/k8s-pod-create-flow.png)
Pod 创建流程：
> 说明：所有的组件只与 APIServer 做交互，APIServer 再把信息更新的 Etcd 中。

1. 用户向 Kubernetes APIServer 发送创建（create/apply）指令。
2. APIServer 接收到配置文件，进行校验，将配置数据存储到 Etcd 中。
3. Contriller-manager 监听 APIServer 的变化，检测到有新的 Pod 对象时，控制器创建 Pod 并且将其状态设为 Pending 。
4. Scheduler 也通过监听 APIServer 的变化，发现有新的、尚未分配节点（Node）的 Pod。根据预选策略和优选策略，选择一个最适合的 Node 来运行新的 Pod 。
5. Pod 被调度到对应的 Node 后，该 Node 上的 kubelet 组件则开始根据 Pod 配置文件，拉镜像、启动 app、就绪探针探测。
6. Kubelet 向 APIServer 上报状态为 Reday，APIServer 写入到 Etcd 中。

## Scheduler Pod 调度流程
Scheduler 的作用是负责将 Pod 调度到 Node 上。
Kubernetes 是如何设计这个组件，保证它稳定高效的运行？
1. 需要能够实时监听到有新的 Pod 待调度。
2. 同一时间如果有大量待调度的 Pod，如何保证不能漏掉？先处理哪个 Pod？调度过程中，如果是失败，如何处理？所以需要加个队列并且有重试机制等。
3. 调度过程中依赖 Node 、 Pod 的实时信息，根据 Node 、 Pod 信息，决策 Pod 调度到哪个 Node 上合适，每次调度都要调用 APIServer 是否低效？得在本地缓存一份数据，加个缓存。
4. 调度选择过程中，考虑因素有很多，很难周全，所以可扩展性一定要设计好。
5. Pod 绑定过程中可能依赖 pvc 绑定等，耗时比较长，所以绑定要是异步的，但是匹配哪个 Node 合适的策略算法，则需要同步执行。所以要有两个周期，调度周期和绑定周期。调度周期串行，绑定周期并行。

以下是调度框架
![k8s-scheduler-frame](../../image/Kubernetes/resource_code_learning/k8s-scheduler-frame.png)

## 源码调用链路
> 原图是用 draw.io 画的，可打开后二次编辑。

![k8s-scheduler-chain](../../image/Kubernetes/resource_code_learning/k8s-scheduler-chain.png)

```sh
# 42 个序号对应的源码位置依次为：
1 找到启动主函数
https://github.com/shychee/kubernetes/blob/v1.31.0-learning/cmd/kube-scheduler/scheduler.go#L31
```

## Scheduler Framework
## 如何扩展插件