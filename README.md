# ActiveStore

Ovaj projekt se bavi implementacijom aktivnih i temporalnih baza podataka pri izradi aplikacije koja služi za vođenje statistike i automatsko upravljanje zalihama, pri tom vodeći se sa jednom od poznatih strategija. Naglasak u ovom radu nije na samoj aplikaciji koja bi služila za uporabu u realnom poslovnom svijetu, već da pokaže osnovne karakteristike aktivnih i temporalnih baza podataka koje su primjenjene. 

U radu je korišten PostgreSQL te pgAdmin4 v4 u kojem su kreirane trigger funkcije i sami triggeri koji su korišteni u projektu. 

Grafičko sučelje je izrađeno u Visual Studio alatu u obliku Windows Form aplikacije pisane u .NET Frameworku. Grafičko sučelje sadrži korisničke kontrole za brze izmjene nad artiklima u skaldištu, mogućnost simulacije izmjene količine artikala na skladištu, pregledavanja i filtriranje povijesti zabilježenih događaja u dnevnku, pregled narudžbi i primki te grafički prikaz statistike na skladištu.

### Postupci prije pokretanja

Pokrenuti pgAdmin4 na računalu i ostaviti uključen za vrijeme rada aplikacije

### Prvo pokretanje aplikacije

#### 1) pgAdmin 4.0

*Postoje naznake kod službene dokumentacije da ukoliko se verzije pgAdmin ne podudaraju, neke stvari možda neće  ispravno raditi.*

1. Pokrenuti pgAdmin na računalu
2. Desni klik na PosgreSQL 11 -> *Create...* -> *Database...* -> *naziv*: 'activeStore', *owner*: 'postgres'
3. Unutar baze otvoriti **novi Query** te unutar njega **izvršiti kompletan sadržaj *'activeStore - database dump.sql'* datoteke**
4. Ostaviti pgAdmin 4 uključen za vrijeme rada aplikacije

#### 2) Visual Studio

1. Otvoriti datoteku *ActiveStore\ActiveStore\Klase\Konekcija.cs*
2. **ConnectionString** - izmjeniti *UserId* i *Password* sukladno podacima kod vašeg pgAdmin
3. Spremanje promjena i spremni za korištenje
