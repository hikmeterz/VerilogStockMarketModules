`timescale 1ns / 1ps
module borsa_guvenli(
    input [36:0] yatirimci_kimlikno ,
    input [9:0] hisse_numarasi1,
    input [31:0] hisse_deger1,
    input [9:0] hisse_numarasi2,
    input [31:0] hisse_deger2,
    input [9:0] hisse_numarasi3,
    input [31:0] hisse_deger3,
    input [63:0] bakiye,
    output reg[1:0] karar,
    output reg[63:0] kagit_sayisi,
    
    output reg[63:0]  sifre_cikisi,
    output reg[15:0]  sifre_anahtari
    );

    reg[9:0] karar_no;
    initial begin
        karar_no=10'd0;
        karar=2'b00;
        kagit_sayisi=64'd0;
    end
    
    
    reg [63:0] sonuc1;
    reg [63:0] sonuc2;
    reg [63:0] sonuc3;
    always@(hisse_deger1 or hisse_deger2 or hisse_deger3) begin
        sifre_anahtari=((hisse_numarasi1^hisse_numarasi2)<<6) + hisse_numarasi3;
        sonuc1= bakiye / hisse_deger1; 
        sonuc2= bakiye / hisse_deger2;
        sonuc3= bakiye / hisse_deger3;
        
        if(sonuc1>sonuc2)begin
            if(sonuc1>sonuc3)begin
                karar_no=hisse_numarasi1;
                if(sonuc1>1000)begin
                    karar=2'b01;
                    kagit_sayisi=sonuc1;
                end
            end
            else if(sonuc1<sonuc3)begin
                    karar_no=hisse_numarasi3;
                    if(sonuc3>1000)begin
                        karar=2'b11;
                        kagit_sayisi=sonuc3;
            
                    end
            end
         end
         else if(sonuc1<sonuc2)begin
            if(sonuc2>sonuc3)begin
                karar_no=hisse_numarasi2;
                if(sonuc2>1000)begin
                    karar=2'b10;
                    kagit_sayisi=sonuc2;
                end
            end
            else if(sonuc2<sonuc3)begin
                karar_no=hisse_numarasi3;
                if(sonuc3>1000)begin
                    karar=2'b11;
                    kagit_sayisi=sonuc3;
                end
            end
         end
         else
            karar_no=10'd0;
    
        sifre_cikisi[9:0]=karar_no;
        sifre_cikisi[46:10]=yatirimci_kimlikno;
        sifre_cikisi= sifre_cikisi * sifre_anahtari;
        
        
     end

    
    
    
    
    




endmodule
