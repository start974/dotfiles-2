python
import os
gdb.execute('directory ' + os.environ['OPAM_SWITCH_PREFIX'] + '/lib/ocaml')
end

show directories
