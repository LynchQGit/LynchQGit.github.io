## PyTorch中的torch.nn模块

PyTorch提供了torch.nn模块，以帮助我们创建和训练神经网络。我们将首先在MNIST数据集上训练基本的神经网络，不使用这些模型的任何特征。我们仅使用基本的PyTorch张量功能，然后逐步添加torch.nn中的一个特征。

>torch.nn为我们提供了许多类和模块，用于实现和训练神经网络。

nn模块包含以下模块和类：
| 序号  |             类和模块             |                      描述                      |
| :---: | :------------------------------: | :--------------------------------------------: |
|   1   |        torch.nn.Parameter        |              模块参数的张量类型。              |
|   2   |               容器               |            所有神经网络模块的基类。            |
|  2.1  |         torch.nn.Module          |            所有神经网络模块的基类。            |
|  2.2  |       torch.nn.Sequential        |         顺序容器，按传递顺序添加模块。         |
|  2.3  |       torch.nn.ModuleList        |              在列表中保存子模块。              |
|  2.4  |       torch.nn.ModuleDict        |              在字典中保存子模块。              |
|  2.5  |      torch.nn.ParameterList      |               在列表中保存参数。               |
|  2.6  |      torch.nn.parameterDict      |               在字典中保存参数。               |
|   3   |              卷积层              |      对输入信号应用一维卷积，二维卷积等。      |
|  3.1  |         torch.nn.Conv1d          |            对输入信号应用一维卷积。            |
|  3.2  |         torch.nn.Conv2d          |            对输入信号应用二维卷积。            |
|  3.3  |         torch.nn.Conv3d          |            对输入信号应用三维卷积。            |
|  3.4  |     torch.nn.ConvTranspose1d     |        对输入图像应用一维转置卷积操作。        |
|  3.5  |     torch.nn.ConvTranspose2d     |        对输入图像应用二维转置卷积操作。        |
|  3.6  |     torch.nn.ConvTranspose3d     |        对输入图像应用三维转置卷积操作。        |
|  3.7  |         torch.nn.Unfold          |        从批量输入张量中提取滑动局部块。        |
|  3.8  |          torch.nn.Fold           |   将一系列滑动局部块组合成一个大的包含张量。   |
|   4   |              池化层              |       应用一维最大池化，二维最大池化等。       |
|  4.1  |        torch.nn.MaxPool1d        |               应用一维最大池化。               |
|  4.2  |        torch.nn.MaxPool2d        |               应用二维最大池化。               |
|  4.3  |        torch.nn.MaxPool3d        |               应用三维最大池化。               |
|  4.4  |       torch.nn.MaxUnpool1d       |         计算 MaxPool1d 的部分逆操作。          |
|  4.5  |       torch.nn.MaxUnpool2d       |         计算 MaxPool2d 的部分逆操作。          |
|  4.6  |       torch.nn.MaxUnpool3d       |         计算 MaxPool3d 的部分逆操作。          |
|  4.7  |        torch.nn.AvgPool1d        |               应用一维平均池化。               |
|  4.8  |        torch.nn.AvgPool2d        |               应用二维平均池化。               |
|  4.9  |        torch.nn.AvgPool3d        |               应用三维平均池化。               |
| 4.10  |   torch.nn.FractionalMaxPool2d   |             应用二维分数最大池化。             |
| 4.11  |        torch.nn.LPPool1d         |             应用一维功率平均池化。             |
| 4.12  |        torch.nn.LPPool2d         |             应用二维功率平均池化。             |
| 4.13  |    torch.nn.AdaptiveMaxPool1d    |            应用一维自适应最大池化。            |
| 4.14  |    torch.nn.AdaptiveMaxPool2d    |            应用二维自适应最大池化。            |
| 4.15  |    torch.nn.AdaptiveMaxPool3d    |            应用三维自适应最大池化。            |
| 4.16  |    torch.nn.AdaptiveAvgPool1d    |            应用一维自适应平均池化。            |
| 4.17  |    torch.nn.AdaptiveAvgPool2d    |            应用二维自适应平均池化。            |
| 4.18  |    torch.nn.AdaptiveAvgPool3d    |            应用三维自适应平均池化。            |
|   5   |              填充层              |     使用反射、复制、零等方法填充输入张量。     |
|  5.1  |     torch.nn.ReflectionPad1d     |        使用输入边界的反射填充输入张量。        |
|  5.2  |    torch.nn.ReplicationPad1d     |        使用输入边界的复制填充输入张量。        |
|  5.3  |        torch.nn.ZeroPad2d        |           使用零填充输入张量的边界。           |
|  5.4  |      torch.nn.ConstantPad1d      |       使用给定填充值填充输入张量的边界。       |
|  ...  |               ...                |                      ...                       |
|   6   |  非线性激活层（加权和，非线性）  |         应用ELU、硬收缩等逐元素函数。          |
|  6.1  |           torch.nn.ELU           |              应用逐元素ELU函数。               |
|  6.2  |       torch.nn.Hardshrink        |             应用逐元素硬收缩函数。             |
|  6.3  |        torch.nn.LeakyReLU        |           应用逐元素LeakyReLU函数。            |
|  6.4  |       torch.nn.LogSigmoid        |           应用逐元素LogSigmoid函数。           |
|  6.5  |          torch.nn.PReLU          |             应用逐元素PReLU函数。              |
|  6.6  |          torch.nn.ReLU           |              应用逐元素ReLU函数。              |
|  ...  |               ...                |                      ...                       |
|   7   |       非线性激活层（其他）       |      应用软最小值、softmax等逐元素函数。       |
|  7.1  |         torch.nn.Softmin         |            应用逐元素软最小值函数。            |
|  7.2  |         torch.nn.Softmax         |            应用逐元素softmax函数。             |
|  ...  |               ...                |                      ...                       |
|   8   |             归一化层             |     应用批归一化、组归一化、实例归一化等。     |
|  8.1  |       torch.nn.BatchNorm1d       |          应用于2D或3D输入的批归一化。          |
|  8.2  |        torch.nn.GroupNorm        |          应用于输入小批量的组归一化。          |
|  ...  |               ...                |                      ...                       |
|   9   |              循环层              |             应用RNN、LSTM、GRU等。             |
|  9.1  |           torch.nn.RNN           |              应用多层Elman RNN。               |
|  9.2  |          torch.nn.LSTM           |        应用多层长短时记忆（LSTM）RNN。         |
|  9.3  |           torch.nn.GRU           |        应用多层门控循环单元（GRU）RNN。        |
|  ...  |               ...                |                      ...                       |
|  10   |              线性层              |                 应用线性转换。                 |
| 10.1  |        torch.nn.Identity         |          占位符身份运算符，无关参数。          |
| 10.2  |         torch.nn.Linear          |            对输入数据应用线性转换。            |
| 10.3  |        torch.nn.Bilinear         |           对输入数据应用双线性转换。           |
|  ...  |               ...                |                      ...                       |
|  11   |              丢失层              |   用于正则化和防止神经元共适应的Dropout层。    |
| 11.1  |         torch.nn.Dropout         |   用于正则化和防止神经元共适应的Dropout层。    |
| 11.2  |      torch.nn.AlphaDropout       |          应用于输入的Alpha Dropout。           |
|  ...  |               ...                |                      ...                       |
|  12   |              稀疏层              |       用于存储和检索Word Embeddings等。        |
| 12.1  |        torch.nn.Embedding        |        用于存储和检索Word Embeddings。         |
| 12.2  |      torch.nn.EmbeddingBag       | 在不实例化中间嵌入的情况下计算嵌入的和或均值。 |
|  ...  |               ...                |                      ...                       |
|  13   |             距离函数             |          计算余弦相似性、成对距离等。          |
| 13.1  |    torch.nn.CosineSimilarity     |          计算x1和x2之间的余弦相似性。          |
| 13.2  |    torch.nn.PairwiseDistance     |        计算向量v1和v2之间的批次对距离。        |
|  ...  |               ...                |                      ...                       |
|  14   |             损失函数             |        用于分类、回归等任务的损失函数。        |
| 14.1  |         torch.nn.L1Loss          | 测量输入x和目标y中每个元素之间的平均绝对误差。 |
| 14.2  |         torch.nn.MSELoss         | 测量输入x和目标y中每个元素之间的平均平方误差。 |
|  ...  |               ...                |                      ...                       |
|  15   |              视觉层              |     重新排列张量元素，上采样多通道数据等。     |
| 15.1  |      torch.nn.PixelShuffle       |               重新排列张量元素。               |
| 15.2  |        torch.nn.Upsample         |               上采样多通道数据。               |
|  ...  |               ...                |                      ...                       |
|  16   | DataParallel层（多GPU，分布式）  |  模块级别实现数据并行性，分布式数据并行性等。  |
| 16.1  |      torch.nn.DataParallel       |            模块级别实现数据并行性。            |
| 16.2  | torch.nn.DistributedDataParallel |         模块级别实现分布式数据并行性。         |
|  ...  |               ...                |                      ...                       |
|  17   |             实用工具             |              clip_grad_norm_等。               |
| 17.1  |     torch.nn.clip_grad_norm_     |          对所有模型参数进行梯度裁剪。          |

### 参考资料:
https://pytorch.org/docs/stable/nn.html
