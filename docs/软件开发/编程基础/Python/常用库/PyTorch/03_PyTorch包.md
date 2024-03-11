## PyTorch 包
PyTorch是一个针对使用CPU和GPU进行深度学习的优化张量库。PyTorch拥有丰富的包，用于执行深度学习概念。这些包帮助我们进行优化、转换、损失计算等。让我们简要了解这些包。

| 序号  |          包名称          |                                                    描述                                                    |
| :---: | :----------------------: | :--------------------------------------------------------------------------------------------------------: |
|   1   |          torch           |                    torch包包含用于多维张量的数据结构，以及对这些张量的数学运算的定义。                     |
|   2   |       torch.Tensor       |                                 该包是一个包含单一数据类型元素的多维矩阵。                                 |
|   3   |         张量属性         |                                                                                                            |
|       |     (a) torch.dtype      |                                      表示torch.Tensor数据类型的对象。                                      |
|       |     (b) torch.device     |                                    表示将分配torch.Tensor的设备的对象。                                    |
|       |     (c) torch.layout     |                                     表示torch.Tensor的内存布局的对象。                                     |
|   4   |         类型信息         |                        可以通过torch.iinfo或torch.finfo访问torch.dtype的数值属性。                         |
|       |     (1) torch.finfo      |                                   表示浮点torch.dtype的数值属性的对象。                                    |
|       |     (2) torch.iinfo      |                                   表示整数torch.dtype的数值属性的对象。                                    |
|   5   |       torch.sparse       |          Torch支持以COO（坐标）格式存储和处理稀疏张量，这将高效地存储和处理大多数元素为零的张量。          |
|   6   |        torch.cuda        |                    Torch支持CUDA张量类型，其实现与CPU张量相同，但在计算方面利用了GPU。                     |
|   7   |      torch.Storage       |                            torch.Storage是一个连续的、一维的单一数据类型数组。                             |
|   8   |         torch.nn         |                           该包为我们提供了许多用于实现和训练神经网络的类和模块。                           |
|   9   |   torch.nn.functional    |                                      该包具有与torch.nn类似的功能类。                                      |
|  10   |       torch.optim        |                                         该包用于实现各种优化算法。                                         |
|  11   |      torch.autograd      |                           该包提供了用于实现任意标量值函数的自动微分的类和函数。                           |
|  12   |    torch.distributed     |                                        该包支持三种不同功能的后端。                                        |
|  13   |    torch.distribution    |                          该包允许我们构建随机计算图，并为优化提供随机梯度估计器。                          |
|  14   |        torch.hub         |                              它是一个预训练模型仓库，旨在促进研究的可重现性。                              |
|  15   |  torch.multiprocessing   |                                   它是对本机multiprocessing模块的包装。                                    |
|  16   |  torch.utils.bottleneck  |                               它是一个用于在程序中调试瓶颈的初始步骤的工具。                               |
|  17   |  torch.utils.checkpoint  |                                         用于在源程序中创建检查点。                                         |
|  18   | torch.tils.cpp_extension |                                    用于创建C++、CUDA和其他语言的扩展。                                     |
|  19   |     torch.utils.data     |                                          该包主要用于创建数据集。                                          |
|  20   |    torch.utils.dlpack    |                                          用于将Dlpack解码为张量。                                          |
|  21   |        torch.onnx        | ONNX导出器是一种基于跟踪的导出器，这意味着它通过执行您的模型一次并导出实际在此运行期间运行的运算符来操作。 |

### 参考:
https://pytorch.org/docs/stable/index.html
