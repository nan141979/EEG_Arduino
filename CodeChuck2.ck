SerialIO.list() @=> string list[];

for(int i; i < list.cap(); i++)
{
    chout <= i <= ": " <= list[i] <= IO.newline();
}

// parse first argument as device number
1 => int device;
if(me.args()) {
    me.arg(1) => Std.atoi => device;
}

if(device >= list.cap())
{
    cherr <= "serial device #" <= device <= " not available\n";
    me.exit(); 
}

SerialIO cereal;
if(!cereal.open(device, SerialIO.B9600, SerialIO.ASCII))
{
    chout <= "unable to open serial device '" <= list[device] <= "'\n";
    me.exit();
}

// Configurando musicas
SndBuf Som1 => dac;

int val;
int soma;
int media; 
int contador;
0 => contador; // começa na posição 0
// MAIN MENU  
while (contador <= 16) 
{

    
    
    spork ~ serial();  
    spork ~ mediaL();
    spork ~ play();
     
    45::second => now;

    contador + 1 => contador; 
    <<< contador >>>;   
   }


//FUNCOES   
fun void serial() {
    
     int valArray[100]; // toda vez que ele entra no Serial ele cria o array para tirar a média  ( isso faz 0 o array) 
        for( 0 => int i; i < valArray.cap(); i++ )
          {
             cereal.onLine() => now;
             cereal.getLine() => string line;
            
               if(line$Object != null) {
                 line <= IO.newline();
                 StringTokenizer valor;
                 valor.set(line);
                 Std.atoi(valor.next()) => val;   
               //  <<< "Leitura Atencao: ", val, " % ">>>;             
                 val @=> valArray[i];
                 valArray[i] + soma => soma;         
               
                 <<< "Valor  Medido de atencao: ", valArray[i] >>>;
                }
                
            
               
          }
     
 }
  
     
fun void play() {
    //Condicoes Ifs 
    while (media <= 50) {
        <<< "Concentracao abaixo de 50 ">>>;
        me.dir()  + "/Sons/relaxar.wav" => Som1.read;
        Som1.samples() => Som1.pos;
        0 => Som1.pos; 
        0.9 => Som1.gain; 
        3::minute => now; 
    }
    
    while(media > 50) 
       {
        <<< "Concentracao acima de 50 ">>>;
        me.dir()  + "/Sons/meditation.wav" => Som1.read;
        Som1.samples() => Som1.pos;
        0 => Som1.pos; 
        0.9 => Som1.gain; 
        3::minute => now;  
  
    }    
}

fun void mediaL(){
   <<<"Valor da soma:", soma >>>;
  (soma/100) => media; 
 // <<< "A media e de: ", media >>>;
      0 => soma;
   // <<< "A soma zerou:", soma>>>;
                  
  
}
