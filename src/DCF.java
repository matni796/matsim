import java.awt.CardLayout;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;

import javax.swing.BorderFactory;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSlider;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

public class DCF implements ActionListener,ChangeListener{

	double PricePerShare; //Enterprice Value per Share
	double WACC;	//Weighted Average Cost of Capital
	double NoOfShares; //No of outstanding shares
	double Debt; //Market Value of Debt
	double Equity; //Equity as in Income Statement
	double Taxrate = 0.22; //Current government tax rate
	double RiskFreeRate = 0.015; //Current risk free rate
	double Beta; //Specific beta
	double MarketPremium; //Market premium for this business
	double CostOfDebt = 0.044; //Average interest rate
	double[] DCFlist; //List of Discounted cash flows
	double MarketCap; //Market value of shares times number of shares
	double MinorityInerests; //Minority shares in other companies
	double PensionLiab; //Unfunded Pension Liabilities
	double Cash; //Cash and Cash equivalents
	double[] HistRevenue; //Historical Revenues
	double[] PredRevenue; //Predicted Revenues
	double[] HistEBITDA; //Historic EBITDA
	double[] PredEBITDA; //Predicted EBITDA
	double[] HistReinv; //Historical Reinvestment Rate
	double[] PredReinv; //Predicted Reinvestment Rate
	JLabel label2= new JLabel();
	

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new DCF();
	}
	public DCF(){
		HistRevenue=new double[] {14000,15000,16000,17000};
		HistEBITDA= new double[] {4000,5000,6000,7000};
		HistReinv=new double[] {2000,2300,2400,2500};
		Debt = 500000;
		Equity = 250000;
		NoOfShares = 100000;
		MarketCap=NoOfShares*30;
		
		predictions(5);
		System.out.println(PredRevenue.length);
		waccCalculation();
		System.out.println(WACC);
		JFrame frame = new JFrame("DCF");
		frame.setSize(300,300);
		JPanel main = new JPanel();
		main.setLayout(new GridLayout(3,1));
		frame.add(main);
		JLabel label1=new JLabel("Revenue Growth");
		label1.setText("Growth");
		JPanel panel1=new JPanel(new GridLayout(1,5));
		for(int i=0;i<PredRevenue.length;i++){
			JSlider Revenue=new JSlider(JSlider.VERTICAL,-20,30,(int)(PredRevenue[i]*100));
			Revenue.addChangeListener(this);
			panel1.add(Revenue);
			Revenue.setMajorTickSpacing(10);
	        Revenue.setMinorTickSpacing(1);
	        Revenue.setPaintTicks(true);
	        Revenue.setPaintLabels(true);
	        Revenue.setBorder(
	                BorderFactory.createEmptyBorder(0,0,10,0));
	        Font font = new Font("Serif", Font.ITALIC, 10);
	        Revenue.setFont(font);
		}
		main.add(label1);
		main.add(panel1);
		main.add(label2);
		
		
		
		frame.setVisible(true);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	
	
	private void predictions(int y){
		PredRevenue=new double[y];
		PredEBITDA=new double[y];
		PredReinv=new double[y];
		double avgRevenue = 0;
		double avgEBITDA = 0;
		double avgReinv = 0;
		for(int i=1;i<HistRevenue.length;i++){
			avgRevenue+=(HistRevenue[i]-HistRevenue[i-1])/HistRevenue[i-1];
			avgEBITDA+=(HistEBITDA[i]-HistEBITDA[i-1])/HistEBITDA[i-1];
			avgReinv+=(HistReinv[i]-HistReinv[i-1])/HistReinv[i-1];
		}
		avgRevenue=avgRevenue/HistRevenue.length;
		avgEBITDA=avgEBITDA/HistEBITDA.length;
		avgReinv=avgReinv/HistReinv.length;
		for(int i=0;i<y;i++){
			PredRevenue[i]=avgRevenue;
			PredEBITDA[i]=avgEBITDA;
			PredReinv[i]=avgReinv;
		}
	}
	

	private double waccCalculation() {
		WACC = (Debt / (Debt + Equity)) * CostOfDebt * (1 - Taxrate)
				+ (Equity / (Debt + Equity))
				* (RiskFreeRate + Beta * MarketPremium);
		return WACC;
	}
	
	private void CashFlow(){
		DCFlist = new double[PredRevenue.length];
		for(int k=0;k<PredRevenue.length;k++){
			double revenue=1;
			double EBITDA=1;
			double reinvest=1;
			for(int i=0;i<=k;i++){
				revenue=revenue*(1+PredRevenue[i]);
				EBITDA=EBITDA*(1+PredEBITDA[i]);
				reinvest=reinvest*(1+PredReinv[i]);
			}
			DCFlist[k]=((HistRevenue[HistRevenue.length-1]*revenue*EBITDA)-(HistRevenue[HistRevenue.length-1]*revenue*reinvest));
		}
	}

	private double perShareValue() {
		double entValue = MarketCap + MinorityInerests + Debt + PensionLiab
				+ Cash;
		for (int k = 0; k < DCFlist.length; k++) {
			entValue = entValue + (DCFlist[k] * Math.pow((1 + WACC), k));
		}
		PricePerShare = entValue / NoOfShares;
		return PricePerShare;
	}

	@Override
	public void actionPerformed(ActionEvent arg0) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void stateChanged(ChangeEvent arg0) {
		// TODO Auto-generated method stub
		JSlider e=(JSlider) arg0.getSource();
		System.out.println(e.getValue());
		CashFlow();
		perShareValue();
		label2.setText(String.valueOf(PricePerShare));
	}

}
