import fwrap as fw
import numpy as np

fiop = fw.f_interoperable_t()
print(fiop)
fiop.init_interoperable_t()
fiop.show_interoperable_t()
fiop.bai_interoperable_t()
fiop.show_interoperable_t()
print(fiop)

funiop = fw.f_uninteroperable_t(4,3)
funiop.show()
funiop.r64_2d[0,0] = 10
print(f'funiop:{funiop}\n',
      f'i32={funiop.i32}, d64={funiop.d64}\n',
      f'r64_1d={np.asarray(funiop.r64_1d)}\n',
      f'r64_2d=\n{np.asarray(funiop.r64_2d)}, shape={funiop.r64_2d.shape}\n',
      f'r64_1d_p={np.asarray(funiop.r64_1d_p)}\n',
      f'r64_2d_p=\n{np.asarray(funiop.r64_2d_p)}, shape={funiop.r64_2d.shape}',
      )
funiop.show()