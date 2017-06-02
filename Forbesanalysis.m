%%
%%MATLABFinalProject
%% Url: www.Forbes.com
%% << Alex Vizhalil >>
%% U. of Illinois, Chicago
%% CS109, Fall 2015
%% Final Project
function Forbesanalysis(filename, filename2)
  fprintf('** The Forbes Top 50 Ranking of the Worlds Biggest Companies (Year 2014) **\n');
  fprintf('\n');
  
  data = dataset('XLSFile', filename,'ReadVarNames', true);
  data2 = dataset('XLSFile', filename2,'ReadVarNames', true);
   operation = menu('Please select an operation:' ,'Graph Country Pie Chart' ,'Industry Vs Total Values', 'Plot individual company values');
  
  if operation == 1
      PlotPieChart(data, data2);
  elseif operation == 2
      PlotIndustryVSValue(data);
  elseif operation == 3
      PlotCompanyvalues(data);
  else    
      fprintf('**Error, unknown operation\n');
  end
  
  fprintf('\n');
end

function PlotPieChart(data, data2)
   [XNames i j]=unique(data2.country);
   XPercentage=histc(j,1:length(XNames));
   X1 = flipud( XPercentage);
   X2 = flipud( XNames);
   [YNames x y]=unique(data.Country);
   YPercentage=histc(y,1:length(YNames));
   Y1 = flipud( YPercentage);
   Y2 = flipud( YNames);
   ax1 = subplot(1,2,1);
   ax2 = subplot(1,2,2);
   pie(ax1,X1);
   legend(ax1,X2);
   pie(ax2,Y1);
   legend(ax2,Y2);
   title(ax1,'Percentage of Top 50 Companies per Country for 2004');
   title(ax2,'Percentage of Top 50 Companies per Country for 2014');
end

function PlotIndustryVSValue(data)
[x]=unique(data.Industry);
 for i = [1:19]
     LI = strcmp(data.Industry, x(i)) == 1;
     total = data(LI, :);
     marketvalue1(i) = sum(total.Market_Value);
     sales1(i) = sum(total.Sales);
     profits1(i) = sum(total.Profits);
 end
  Y = cat(1, marketvalue1,sales1,profits1);
  bar3(Y)
 
  title('Industries vs total Market Value, Sales, and Profits','FontWeight','bold','FontSize',24)
  zlabel('Amount in Billions (USD)')
  label = strvcat('Market Value', 'Sales', 'Profits');
  set(gca,'XTickLabel',x);
  ax.XTickLabelRotation = -45; 
  set(gca,'YTickLabel',label);
  set(gca,'xtick',1:19);
  set(gca,'ytick',[1:3]);
  set(gca,'ztick',[0:500:3000]);
end

function PlotCompanyvalues(data)
    A = data.Rank;
    B = data.Company;
    C={[num2str(A) repmat(' ',size(A,1),1) char(B)]};
    C{:}

    a= inputdlg('Select the rank of the first company between 1 and 50','26',1);
    x=str2num(a{1});
    b= inputdlg('Select the rank of the second company between 1 and 50','28',1);
    y=str2num(b{1});
    
    company = data.Company(x);
    company2 = data.Company(y);
    
    LI = strcmp(data.Company, company ) == 1;
    LI2 = strcmp(data.Company, company2 ) == 1;
    List = data(LI, :)
    List2 = data(LI2, :)
    
    marketvalue = List.Market_Value;
    sales = List.Sales;
    profits = List.Profits;
    assets = List.Assets;
    marketvalue2 = List2.Market_Value;
    sales2 = List2.Sales;
    profits2 = List2.Profits;
    assets2 = List2.Assets;
    
    s1 = List.Company;
    s2 = List2.Company;
    s3 =char(s1);
    s4 =char(s2);
    
    Y = cat(1, marketvalue,sales,profits,assets);
    Y2 = cat(1, marketvalue2,sales2,profits2,assets2);
    
    xlab = 'Financial Values of '; 
    str1 =sprintf('%s',xlab,s3);
    str2 =sprintf('%s',xlab,s4);
    
    figure
    subplot(2,1,1);
    bar(Y,'r')
    legend(List.Company)
    xlabel(str1);
    ylabel('Amount in Billions (USD)')
    label = strvcat('Market Value', 'Sales', 'Profits', 'Assets');
    set(gca,'XTickLabel',label)
    title('Comparison Between Two Companies')
    
    subplot(2,1,2);
    bar(Y2,'b')
    legend(List2.Company)
    xlabel(str2);
    ylabel('Amount in Billions (USD)')
    label = strvcat('Market Value', 'Sales', 'Profits', 'Assets');
    set(gca,'XTickLabel',label) 
    title('Comparison Between Two Companies')
end
