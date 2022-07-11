% calculate how often the participants choose the "correct" (= higher) EV,
% probability, magnitude option

clear all, clc; 

vp = {'3'; '4'; '5'; '6'; '7'; '8'; '9'; '10'; '11'; '12'; '13'; '14'; 
     '15'; '16'; '17'; '18'; '19'; '20'; '21'; '22'; '23'; '24'; '25'; '26'; 
     '27'; '28'; '29'; '30'; '33'; '34'; '35'; '36'; '37'; '38'; 
    '39'; '40'; '41'; '42'; '43'; '44'; '45'; '46'; '47'; '48'; '49'; '50';
     '51'; '52'; '53'; '54'; '55'; '56'; '57'; '58'; '59'; '60'; '61'; '62'; 
     '63'; '64'}; % exclude 1, 2, 31, 32

for iteration = 1:numel(vp)
    
    data = readtable(['//Users/marlene/Desktop/Masterarbeit/ma_code/ml/data/ml-',vp{iteration},'.csv']);
    data = rmmissing(data,'DataVariables',["choice"]); % remove trials without a choice
 
    ev_corr = data.ev_correct; 
    prob_corr = data.prob_correct;
    magn_corr = data.mag_correct; 
    mean_ev = mean(ev_corr); 
    mean_prob = mean(prob_corr); 
    mean_magn = mean(magn_corr); 

    mean_correct_table(iteration,:) = [mean_ev mean_prob mean_magn];
    mean_correct_table_test(iteration,:) = [mean_ev mean_prob mean_magn];
   
end

mean_ev_all = mean(mean_correct_table(:,1)); 
sd_ev_all = std(mean_correct_table(:,1));
mean_p_all = mean(mean_correct_table(:,2)); 
sd_p_all = std(mean_correct_table(:,2));
mean_m_all = mean(mean_correct_table(:,3)); 
sd_m_all = std(mean_correct_table(:,3));

all_participants = ["-", "EV", "P", "M"; "mean", mean_ev_all, mean_p_all, mean_m_all; 
    "sd", sd_ev_all, sd_p_all, sd_m_all];

save('//Users/marlene/Desktop/Masterarbeit/ma_code/ml/results/mean_correct/mean_correct_table','mean_correct_table');
save('//Users/marlene/Desktop/Masterarbeit/ma_code/ml/results/mean_correct/all_participants','all_participants');
