from urllib.request import urlopen
from datetime import datetime
import json
url="http://172.8.0.3/elekter.json"
page=urlopen(url)
json=json.loads(page.read())

#print(json['eestiasi']['muutmise_aeg'])

f=open("/home/tins/elekter.txt", "a")
#print(datetime.now())
now=datetime.now().strftime("%d/%m/%Y %H:%M:%S")
when=json['eestiasi']['muutmise_aeg']


f.write(now+"\n")
f.write("muutmise aeg: "+json['eestiasi']['muutmise_aeg']+"\n")
f.write("hind praegu: "+json['eestiasi']['hind_praegu']+"\n")
f.write("hind järgmine tund: "+json['eestiasi']['hind_jrg_tund']+"\n")
f.write('\n')
f.close()