rocotorun -d /scratch1/BMC/gsd-fv3-dev/MAPP_2018/pagowski/expruns/jedi-3denvar-aeroDA-modis/dbase/3denvar-aeroDA-modis.db -w /scratch1/BMC/gsd-fv3-dev/MAPP_2018/pagowski/expruns/jedi-3denvar-aeroDA-modis/dr-work/jedi-3denvar-aeroDA-modis.xml

rocotostat -d /scratch1/BMC/gsd-fv3-dev/MAPP_2018/pagowski/expruns/jedi-3denvar-aeroDA-modis/dbase/3denvar-aeroDA-modis.db -w /scratch1/BMC/gsd-fv3-dev/MAPP_2018/pagowski/expruns/jedi-3denvar-aeroDA-modis/dr-work/jedi-3denvar-aeroDA-modis.xml -c:

rocotocheck -d /scratch1/BMC/gsd-fv3-dev/MAPP_2018/pagowski/expruns/jedi-3denvar-aeroDA-modis/dbase/3denvar-aeroDA-modis.db -w /scratch1/BMC/gsd-fv3-dev/MAPP_2018/pagowski/expruns/jedi-3denvar-aeroDA-modis/dr-work/jedi-3denvar-aeroDA-modis.xml -c 201606090600 -t gdaseupd

rocotoboot -d /scratch1/BMC/gsd-fv3-dev/MAPP_2018/pagowski/expruns/jedi-3denvar-aeroDA-modis/dbase/3denvar-aeroDA-modis.db -w /scratch1/BMC/gsd-fv3-dev/MAPP_2018/pagowski/expruns/jedi-3denvar-aeroDA-modis/dr-work/jedi-3denvar-aeroDA-modis.xml -c 201606090600 -t gdaseupd

rocotorewind -d /scratch1/BMC/gsd-fv3-dev/MAPP_2018/pagowski/expruns/jedi-3denvar-aeroDA-modis/dbase/3denvar-aeroDA-modis.db  -w /scratch1/BMC/gsd-fv3-dev/MAPP_2018/pagowski/expruns/jedi-3denvar-aeroDA-modis/dr-work/jedi-3denvar-aeroDA-modis.xml -c 201606090600 -t gdaseupd

