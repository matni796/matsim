
public class DCF {

	double PricePerShare;
	double WACC;
	double NoOfShares;
	double Debt;
	double Equity;
	double Taxrate=0.22;
	double RiskFreeRate=0.015;
	double Beta;
	double MarketPremium;
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	
	private double waccCalculation(){
		WACC=(Debt/(Debt+Equity))*CostOfDebt*(1-Taxrate)+(Equity/(Debt+Equity))*(RiskFreeRate+Beta*MarketPremium);
		return WACC;
	}

}
