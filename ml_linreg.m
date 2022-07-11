% linear regression of factors influencing RT

clear all, clc; 

addpath('/Users/marlene/Desktop/Masterarbeit/ma_code/vbm/github_repo');

vp = {'3'; '4'; '5'; '6'; '7'; '8'; '9'; '10'; '11'; '12'; '13'; '14'; 
    '15'; '16'; '17'; '18'; '19'; '20'; '21'; '22'; '23'; '24'; '25'; '26'; 
    '27'; '28'; '29'; '30'; '33'; '34'; '35'; '36'; '37'; '38'; 
    '39'; '40'; '41'; '42'; '43'; '44'; '45'; '46'; '47'; '48'; '49'; '50';
    '51'; '52'; '53'; '54'; '55'; '56'; '57'; '58'; '59'; '60'; '61'; '62'; 
    '63'; '64'}; %exclude 1, 2, 31, 32

subps = load("optlearnprob.mat"); % probabilities estimated by bayes learner

for iteration = 1:numel(vp)
    data = readtable(['//Users/marlene/Desktop/Masterarbeit/ma_code/ml/data/ml-',vp{iteration},'.csv']);
    tf = isfinite(data.choice_side); 
    data = rmmissing(data,'DataVariables',["choice_side"]); % remove trials without a choice
    
    subpls = subps.optlearnprob(iteration,:); 

    for k = 1:length(tf)
    if tf(k) == 0 
    subpls(k) = [];
    end
    end 

    subprs = 1 - subpls; 

    subpls = subpls'; 
    subprs = subprs'; 

    subpls_demeaned = subpls - mean(subpls); 
    subprs_demeaned = subprs - mean(subprs); 

    ml = data.mag_left; 
    ml_demeaned = ml - mean(ml); 
    mr = data.mag_right; 
    mr_demeaned = mr - mean(mr); 

    evl = subpls_demeaned .* ml_demeaned; 
    evr = subprs_demeaned .* mr_demeaned; 

    subpd = abs(subpls - subprs); % probability difference
    md = abs(ml - mr); % magnidute difference

    ntrials = size(data,1); 

    choices = data.choice_side;
    choices = choices + 1; 
    rts = data.resp_time;
 
    vd = abs(evl - evr); 
    vsum = evl + evr;

    prerts = [0; rts(1:end-1)]; % rt on previous trial 
    prechoices = [0; choices(1:end-1)]; % choice on previous trial
    choicerep = double(prechoices == choices); % choice repetition

    reward = data.reward >= 1; 
    prereward = [0; reward(1:end-1)]; % reward previous trial

    y = log(rts); 

    x = zscore([subpd, md, vd, vsum, prerts, choicerep, prereward]); % design matrix with predictor variables
   
    [linreg] = fitlm(x,zscore(y)); 

    c(iteration,:) = linreg.Coefficients.Estimate;
    p(iteration,:) = linreg.Coefficients.pValue; 
    
end 

[H,P,CI,stats] = ttest(c); 
check = mes(c,0,'U3_1');

betas = mean(c); 
error = std(c)./sqrt(size(c,1)); 
names = {'constant', 'subpd', 'md', 'vd', 'vsum', 'preRTs', 'choicerep', 'prereward'};

figure;
bar(betas,'FaceColor', '[0 0.5 0');
hold all 
h = errorbar(1:size(c,2), betas, error, 'linestyle', 'none', 'linewidth', 1, 'color', 'k');
set(gca,'box','off', 'tickdir', 'out', 'fontsize', 14, 'xticklabel', names);
ylabel('coefficient estimates', 'FontSize', 16)
set(gcf,'color','w');
text(2.9, 0.0823, '*', 'FontSize', 20);
text(3.9, 0.0722, '*', 'FontSize', 20);
text(5.9, 0.196, '*', 'FontSize', 20);
text(7.9, 0.03, '*', 'FontSize', 20);

ml_results_linreg.coeffnames = {'constant', 'sub_pd', 'md', 'vd', 'vsum', 'preRT', 'choicerep', 'prerew'};
ml_results_linreg.coeffs = c;
ml_results_linreg.pvalues = P; 
ml_results_linreg.tvalues = stats.tstat;

save('//Users/marlene/Desktop/Masterarbeit/ma_code/ml/results/ml_results_linreg.mat','ml_results_linreg');
    
