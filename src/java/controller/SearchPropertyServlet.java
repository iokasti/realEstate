package controller;

import entities.Property;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.AlgorithmIO;
import service.PropertyIO;

public class SearchPropertyServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String location = request.getParameter("location");

        String amount = (String) request.getParameter("amount");
        String n1 = "", n2 = "";
        boolean first = true;
        for (int i = 0; i < amount.length(); i++) {
            if (Character.isDigit(amount.charAt(i))) {
                if (first) {
                    n1 = n1 + amount.charAt(i);
                } else {
                    n2 = n2 + amount.charAt(i);
                }
            } else if (amount.charAt(i) == '-') {
                first = false;
            }
        }
        int lowam = Integer.parseInt(n1);
        int higham = Integer.parseInt(n2);
        int amw = Integer.parseInt(request.getParameter("amountw"));

        String mamount = (String) request.getParameter("mamount");
        String m1 = "", m2 = "";
        boolean mfirst = true;
        for (int i = 0; i < mamount.length(); i++) {
            if (Character.isDigit(mamount.charAt(i))) {
                if (mfirst) {
                    m1 = m1 + mamount.charAt(i);
                } else {
                    m2 = m2 + mamount.charAt(i);
                }
            } else if (mamount.charAt(i) == '-') {
                mfirst = false;
            }
        }
        int lowmein = Integer.parseInt(m1);
        int highmein = Integer.parseInt(m2);
        int meinw = Integer.parseInt(request.getParameter("mamountw"));

        String bamount = (String) request.getParameter("bamount");
        String b1 = "", b2 = "";
        boolean bfirst = true;
        for (int i = 0; i < bamount.length(); i++) {
            if (Character.isDigit(bamount.charAt(i))) {
                if (bfirst) {
                    b1 = b1 + bamount.charAt(i);
                } else {
                    b2 = b2 + bamount.charAt(i);
                }
            } else if (bamount.charAt(i) == '-') {
                bfirst = false;
            }
        }
        int lowbuild = Integer.parseInt(b1);
        int highbuild = Integer.parseInt(b2);
        int buildw = Integer.parseInt(request.getParameter("bamountw"));

        String samount = (String) request.getParameter("samount");
        String s1 = "", s2 = "";
        boolean sfirst = true;
        for (int i = 0; i < samount.length(); i++) {
            if (Character.isDigit(samount.charAt(i))) {
                if (sfirst) {
                    s1 = s1 + samount.charAt(i);
                } else {
                    s2 = s2 + samount.charAt(i);
                }
            } else if (samount.charAt(i) == '-') {
                sfirst = false;
            }
        }
        int lowsq = Integer.parseInt(s1);
        int highsq = Integer.parseInt(s2);
        int sqw = Integer.parseInt(request.getParameter("samountw"));

        boolean Sale, Rent;
        String Sale_Rent = request.getParameter("Sale_Rent");
        if (Sale_Rent.equals("Sale")) {
            Sale = true;
            Rent = false;
        } else {
            Sale = false;
            Rent = true;
        }
        boolean Apartment, House;
        String Apartment_House = request.getParameter("Apartment_House");
        switch (Apartment_House) {
            case "Apartment":
                Apartment = true;
                House = false;
                break;
            case "House":
                Apartment = false;
                House = true;
                break;
            default:
                Apartment = true;
                House = true;
                break;
        }
        boolean heatingSystem = false;
        String heating_System = request.getParameter("heatingSystem");
        if (heating_System != null && !heating_System.equals("")) {
            heatingSystem = true;
        }
        boolean airConditioner = request.getParameter("airConditioner") != null;
        boolean parking = request.getParameter("parking") != null;
        boolean elevator = request.getParameter("elevator") != null;
        String city = request.getParameter("city");

        List<Property> properties = PropertyIO.getallProperties();
        List<Property> preresults = new ArrayList<Property>();
        Map<Property, Double> results = new HashMap<Property, Double>();
        int maxprice = 1, maxmein = 1, maxyear = 1;
        float maxsq = 1;
        for (Property p : properties) {
            if (((Sale && p.isForSale()) || (Rent && p.isForRent()))
                    && ((Apartment && p.isIsApartment()) || (House && p.isIsHouse()) || (Apartment && House))
                    && ((heatingSystem && !p.getHeatingSystem().equals("none")) || (!heatingSystem))
                    && ((airConditioner && p.isAirConditioner()) || (!airConditioner))
                    && ((parking && p.isParking()) || (!parking))
                    && ((elevator && p.isElevator()) || (!elevator))
                    && ((city.equals(p.getCity())) || city.equals("Any"))
                    && ((lowam <= p.getPrice().intValue() && higham >= p.getPrice().intValue()))
                    && (lowbuild <= p.getBuildDate() && highbuild >= p.getBuildDate())
                    && (lowsq <= p.getSqMeters() && highsq >= p.getSqMeters())) {
                if ((p.getMaintenanceCharges() == null && lowmein == 0)
                        || (p.getMaintenanceCharges() != null && lowmein <= p.getMaintenanceCharges().intValue() && highmein >= p.getMaintenanceCharges().intValue())) {
                    preresults.add(p);
                    if (AlgorithmIO.runningSaw()) {
                        if (p.getPrice().intValue() < maxprice) {
                            maxprice = p.getPrice().intValue();
                        }
                        if (p.getMaintenanceCharges() != null && p.getMaintenanceCharges().intValue() < maxmein) {
                            maxmein = p.getMaintenanceCharges().intValue();
                        }
                        if (p.getBuildDate() > maxyear) {
                            maxyear = p.getBuildDate();
                        }
                        if (p.getSqMeters() > maxsq) {
                            maxsq = p.getSqMeters();
                        }
                    }
                }
            }
        }
        List<Property> saved = new ArrayList<Property>(preresults.size());
        for (Property p : preresults) {
            saved.add(new Property(p));
        }
        List<Property> squared_preresults;
        List<Property> divided_preresults;
        List<Property> ideal_seperation_preresults;
        List<Property> nideal_seperation_preresults;
        BigInteger Sprice = new BigInteger("0");
        int Smein = 0, SBuild = 0;
        float Ssq = 0;
        double Sprice2, Smein2, SBuild2, Ssq2;
        if (AlgorithmIO.runningSaw()) {
            for (Property p : preresults) {
                double V = ((p.getPrice().intValue() * amw) / maxprice) + ((p.getBuildDate() * buildw) / maxyear) + ((p.getSqMeters() * sqw) / maxsq);
                if (p.getMaintenanceCharges() != null) {
                    V += p.getMaintenanceCharges().intValue() * meinw / maxmein;
                }
                results.put(p, V);
            }
        } else {
            squared_preresults = new ArrayList<Property>(preresults);
            divided_preresults = new ArrayList<Property>(preresults);

            for (Property p : squared_preresults) {
                p.setPrice(new BigDecimal(Math.pow((double) (p.getPrice().intValue()), 2.0)));
                if (p.getMaintenanceCharges() != null) {
                    p.setMaintenanceCharges(new BigDecimal(Math.pow((double) (p.getMaintenanceCharges().intValue()), 2.0)));
                }
                p.setBuildDate((int) Math.pow((double) p.getBuildDate(), 2.0));
                p.setSqMeters((float) Math.pow(p.getSqMeters(), 2.0));
            }
            for (Property p : squared_preresults) {
                Sprice = Sprice.add(p.getPrice().toBigInteger());
                if (p.getMaintenanceCharges() != null) {
                    Smein += p.getMaintenanceCharges().intValue();
                }
                SBuild += p.getBuildDate();
                Ssq += p.getSqMeters();
            }
            Sprice2 = Math.sqrt(Sprice.doubleValue());
            Smein2 = Math.sqrt((double) Smein);
            SBuild2 = Math.sqrt((double) SBuild);
            Ssq2 = Math.sqrt(Ssq);
            for (Property p : divided_preresults) {
                p.setPrice(new BigDecimal((p.getPrice().intValue() / Sprice2) * amw));
                if (p.getMaintenanceCharges() != null) {
                    p.setMaintenanceCharges(new BigDecimal((p.getMaintenanceCharges().doubleValue() / Smein2) * meinw));
                }
                p.setBuildDate((int) ((p.getBuildDate() / SBuild2) * buildw));
                p.setSqMeters((float) ((p.getSqMeters() / Ssq2) * sqw));
            }
            ideal_seperation_preresults = new ArrayList<Property>(divided_preresults);
            nideal_seperation_preresults = new ArrayList<Property>(divided_preresults);
            BigDecimal idealPrice = new BigDecimal(9999999), idealMaintenanceCharges = new BigDecimal(9999999);
            int idealDate = 1900;
            float idealSq = 1;
            BigDecimal nidealPrice = new BigDecimal(0), nidealMaintenanceCharges = new BigDecimal(0);
            int nidealDate = 2014;
            float nidealSq = 1000;
            for (Property p : divided_preresults) {
                if (p.getPrice().compareTo(idealPrice) == -1) {
                    idealPrice = p.getPrice();
                } else if (p.getPrice().compareTo(nidealPrice) == 1) {
                    nidealPrice = p.getPrice();
                }
                if (p.getMaintenanceCharges() != null) {
                    if (p.getMaintenanceCharges().compareTo(idealMaintenanceCharges) == -1) {
                        idealMaintenanceCharges = p.getMaintenanceCharges();
                    } else if (p.getMaintenanceCharges().compareTo(nidealMaintenanceCharges) == 1) {
                        nidealMaintenanceCharges = p.getMaintenanceCharges();
                    }
                } else {
                    idealMaintenanceCharges = new BigDecimal(0);
                }
                if (p.getBuildDate() > idealDate) {
                    idealDate = p.getBuildDate();
                } else if (p.getBuildDate() < nidealDate) {
                    nidealDate = p.getBuildDate();
                }
                if (p.getSqMeters() > idealSq) {
                    idealSq = p.getSqMeters();
                } else if (p.getSqMeters() < nidealSq) {
                    nidealSq = p.getSqMeters();
                }
            }
            Map<Property, Double> sum_ideal_preresults = new HashMap<Property, Double>();
            for (Property p : ideal_seperation_preresults) {
                p.setPrice(p.getPrice().subtract(idealPrice, MathContext.DECIMAL32).pow(2));
                if (p.getMaintenanceCharges() != null) {
                    p.setMaintenanceCharges(p.getMaintenanceCharges().subtract(idealMaintenanceCharges, MathContext.DECIMAL32).pow(2));
                }
                p.setBuildDate((int) Math.pow((double) (p.getBuildDate() - idealDate), 2));
                p.setSqMeters((float) Math.pow((double) (p.getSqMeters() - idealSq), 2.0));
            }
            for (Property p : ideal_seperation_preresults) {
                double S = p.getPrice().doubleValue() + p.getBuildDate() + p.getSqMeters();
                if (p.getMaintenanceCharges() != null) {
                    S += p.getMaintenanceCharges().doubleValue();
                }
                sum_ideal_preresults.put(p, S);
            }
            Map<Property, Double> sum_nideal_preresults = new HashMap<Property, Double>();
            for (Property p : nideal_seperation_preresults) {
                p.setPrice(p.getPrice().subtract(nidealPrice, MathContext.DECIMAL32).pow(2));
                if (p.getMaintenanceCharges() != null) {
                    p.setMaintenanceCharges(p.getMaintenanceCharges().subtract(nidealMaintenanceCharges, MathContext.DECIMAL32).pow(2));
                }
                p.setBuildDate((int) Math.pow((double) (p.getBuildDate() - nidealDate), 2));
                p.setSqMeters((float) Math.pow((double) (p.getSqMeters() - nidealSq), 2.0));
            }
            for (Property p : nideal_seperation_preresults) {
                double S = p.getPrice().doubleValue() + p.getBuildDate() + p.getSqMeters();
                if (p.getMaintenanceCharges() != null) {
                    S += p.getMaintenanceCharges().doubleValue();
                }
                sum_nideal_preresults.put(p, S);
            }
            Map<Property, Double> pre_results2 = new HashMap<Property, Double>();
            for (Property p : sum_ideal_preresults.keySet()) {
                double C = sum_nideal_preresults.get(p) / (sum_ideal_preresults.get(p) + sum_nideal_preresults.get(p));
                pre_results2.put(p, C);
            }
            for (Property p : saved) {
                System.out.println(p.getPrice());
                for (Property pp : pre_results2.keySet()) {
                    if (p.getId().equals(pp.getId())) {
                        results.put(p, pre_results2.get(pp));
                    }
                }
            }
        }

        Map<Property, Double> sorted_results = sortByComparator(results, true);
        List<Property> final_results = new ArrayList<Property>();
        for (Property p : sorted_results.keySet()) {
            final_results.add(p);
        }
        request.getSession().setAttribute("results", final_results);
        response.sendRedirect("results.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    private static Map<Property, Double> sortByComparator(Map<Property, Double> unsortMap, final boolean order) {
        List<Entry<Property, Double>> list = new LinkedList<>(unsortMap.entrySet());
        Collections.sort(list, (Entry<Property, Double> o1, Entry<Property, Double> o2) -> {
            if (order) {
                return o1.getValue().compareTo(o2.getValue());
            } else {
                return o2.getValue().compareTo(o1.getValue());
            }
        });
        Map<Property, Double> sortedMap = new LinkedHashMap<>();
        list.stream().forEach((entry) -> {
            sortedMap.put(entry.getKey(), entry.getValue());
        });
        return sortedMap;
    }

}
