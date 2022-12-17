# Timp de implementare: 
3 zile de Paste.
  
  *Am zis ca nu reusesc sa termin tema pana la deadline, asa ca m-am dat batuta, dar dupa am vazut oportunitatea cu aceste zile libere(de asemenea m-a speriat si 
  mai tare tema 2 asa ca am zis ca-mi dau toata silinta la tema asta).*
  
 # Implementare: 
  A durat o zi intreaga pana sa-mi citesc datele si sa fac print-ul sa ma verific. Am inceput prin a citi fiecare cuvant si a-l salva ("informatii" - "tip", "dedicator"   "bancnota 1", "bancnota 2", "dedicat", si unde este cazul "index"). Am ales sa fac o functie separata "pun_date" unde stochez in functie de tipul header-ului. 
  Am stat 12 ore sa fac print-ul ca nu am observat ca eu initializam inainte de for... Si, deci, bancnotele mele erau aiurea. Dupa un singur insert erau ok, dar dupa...
  Am ales sa fac o functie care sa ma ajute sa determin spatiul de stocare, de care ma folosesc la task-uri, pentru ca o tot o rescriam.
  Am ales sa fac functii separate pt convert, sa nu ma chinui cu atoi.
  "add_last" a mers bine, dar am uitat sa pun (*len)++, asa ca de aici inca cateva ore pierdute.
  La delete_at iar am stat ceva timp ca nu m-am gandit sa salvez spatiul dinainte de memcpy si aici se strica iar.
  La find am uitat un +5. Clasic. 
  La find si delete am avut nevoie de desene ca sa inteleg ce se muta, ce ramane, cat se muta etc.
