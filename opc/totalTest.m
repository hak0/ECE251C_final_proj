datasets = ["SOTS/indoor/hazy/"  "SOTS/outdoor/hazy/" "# O-HAZY NTIRE 2018/hazy/" "# I-HAZY NTIRE 2018/hazy/"];
levels = [2 3 4];
wnames = ["haar","db10","db45","coif1","coif2","sym2","sym4","fk4","dmey","bior1.1","rbio1.1"];
for i = 1:length(datasets)
    for j = 1:length(levels)
        for k = 1:length(wnames)
            dataset = datasets(i);
            level = levels(j);
            wname = wnames(1, k);
            Test(dataset, level, wname)
        end
    end
end