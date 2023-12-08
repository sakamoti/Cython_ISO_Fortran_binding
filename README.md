# Cython_ISO_Fortran_binding

Code for using ISO_Fortran_binding.h from Cython.
By using ISO_Fortran_binding.pxd, it is possible to use Fortran code from Cython in the same way as if you were operating a Fortran program from C.

If you are interested in learning how to use it, please refer to each code in the `test` folder.

To run the test code, type the following commandTo runnning test code, 

```bash
cd test
python3 -m venv env
source env/bin/activate
pip install -r py_main/requirements.txt
make test
```