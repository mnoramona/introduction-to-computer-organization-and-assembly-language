## Timp de implementare:
Undeva la 2 zile, pe langa o saptamana de a intelege cum incep

## Implementare
### Task-ul 1: 
  In acest task am luat un contor pentru a trece prin fiecare litera a cuvantului, pe care il compar cu lungimea cuvantului
Daca lungimea cuvantului este mai mica decat contorul meu ma duc intr-un label pe nume pas care verifica constant acestea doua, dupa care dau jump, daca e valabil, in loop
In loop adaug in sirul initial acel "step", adica fac shiftarea ceruta, compar rezultatul final cu 90, adica litera z, daca am depasit de z dau jump in verificare.
In verificare scad 26 ca mai trec odata prin alfabet, fac un intermediar in al si cu ajutorul lui mut in sirul final litera shiftata, dupa care verific iar in pas daca
ma duc la urmatoarea litera sau nu.
In cazul in care nu ajung in verificare folosesc intermediarul sa fac mutarea direct, fara scadere. De fiecare data cand adaug in sirul final, cresc si contorul pentru 
litere.

### Task-ul 2:
##### exercitiul 1:  
Am observat ca, matematic, pentru drepte paralele cu axele nu mai este necesar sa fac cu sqrt
Am facut in esi un contor, nu stiu de ce m-am gandit ca e inteligent sa incep de la 1 dar nu am avut timp sa schimb asa ca m-am chinuit cu el asa.
Compar contorul cu numarul de puncte(stiu ca am doar doua puncte dar cand l-am facut aveam impresia ca am mai multe puncte) 
In ox imi iau informatiile despre punctele x cresc contorul ca sa iau la doua puncte consecutive
verific daca sunt egale si in functie de asta fac diferenta care va rezulta in distanta ceruta. daca x-urile sunt cele egale, ma duc in oy care fac acelasi algoritm ca 
la ox, doar ca cu y-uri ;)

#### exercitiul 2: 
Am folosit aceeasi tactica pentru coordonate, de data asta am verificat care dintre punctele x1 si x2, respectiv y1 si y2 este mai mare ca sa nu imi rezulte intr-o 
distanta negativa, am calculat distantele si le-am pus in ebx, chinuindu-ma cu pozitia

#### exercitiul 3:
Am folosit un fel de "i" care creste constant si verific de fiecare data daca i * i este numarul sau daca ajung mai mare decat nr respectiv atunci pun 0 in pozitia 
respectiva in rezultat.

### Task 3:
Imi fac niste variabile unde imi salvez lungimile ca aveam registre pe minus, si asa edi si eax devin contori si ii fac 0
In pas verific constant daca trec de lungimea sirului initial, daca da ies, daca nu ma duc in loop
In loop imi mut literele si le compar si dupa nevoie imi fac diferenta
Cand fac diferenta scand litera mica din cea mare, rezultatul in pun in esi, adaug 'A', sau dupa nevoie 26



# nu mai am timp ca este si 51, dar chiar m-am chinuit
