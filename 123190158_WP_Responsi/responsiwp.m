%penyelesaian kasus menggunakan metode WP 
%untuk menampilkan/import data
data = xlsread('Real Estate.xlsx', 'C2:E51');
data1 = xlsread('Real Estate.xlsx', 'H2:H51');
x = [data data1];
k = [1,0,1,0]; %jenis kriteria 1 untuk keuntungan 0 untuk biaya
%atribut tiap-tiap kriteria, dimana nilai 1=atrribut keuntungan, dan 0= atribut biaya
w = [3, 5, 4, 1]; %Nilai bobot tiap kriteria 

%tahapan pertama, perbaikan bobot
[m n]=size (x); %inisialisasi ukuran x 
w = w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif) 
for j=1:n, 
    if k(j)==0, 
        w(j)=-1*w(j); 
    end; 
end; 
for i=1:m, 
    S(i)=prod(x(i,:).^w); 
end;

%tahapan ketiga, proses perangkingan 
V= S/sum(S)