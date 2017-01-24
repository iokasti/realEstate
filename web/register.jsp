<%@page import="entities.User"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script src="javascript/scripts.js" type="text/javascript"></script>
        <title>Find A Residence - Εγγραφή Νέου Χρήστη</title>	
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            if (user != null) {
                response.sendRedirect("index.jsp");
            }
        %>
        <div class="onepcssgrid-1200">
            <div class="onerow">
                <div class="col5">
                    <a href="index.jsp"><img src="images/far.png" alt="logo"/></a>
                </div>
                <div class="col7 last">
                    <div id='cssmenu'>
                        <ul>
                            <li><a href='register.jsp'>Εγγραφή</a></li>
                            <li onclick="popup('login')"><a href='#'>Σύνδεση</a></li>
                            <li><a href='search.jsp'>Αναζήτηση Ιδιοκτησιών</a></li>
                        </ul>
                    </div>
                </div>
                <div id="blanket" style="display:none" onclick="popup('login')"></div>
                <div id="login" style="display:none;">
                    <button type="button" onclick="popup('login')">x</button>
                    <form id="login-form" action="login">
                        <input type="text" placeholder="Όνομα Χρήστη" name="username"/>
                        <input type="password" placeholder="Κωδικός" name="password" />
                        <input type="submit" value="Σύνδεση" />
                    </form>
                </div>
            </div>
            <div class="onerow">
                <div class="col12 last">
                    <h1>Εγγραφή Νέου Χρήστη</h1>
                    <form autocomplete="off" name="register-form" id="general-form" action="registration" onsubmit="return validateRegisterForm()" method="POST">
                        <p class="general"><label for="username">Όνομα Χρήστη <font color="red">*</font>
                            </label></p>
                        <input id="username" type="text" name="username" placeholder="user"/>
                        <p class="general"><label for="password">Κωδικός <font color="red">*</font>
                            </label></p>
                        <input id="password" type="password" name="password"  />
                        <p class="general"><label for="password2">Επιβεβαίωση Κωδικού <font color="red">*</font>
                            </label></p>
                        <input id="password2" type="password" name="password2"  />
                        <p class="general"><label for="email">Email <font color="red">*</font>
                            </label></p>
                        <input id="email" type="email" name="email"  placeholder="user@provider.gr"/>
                        <p class="general">
                            <label for="name">Όνομα <font color="red">*</font>
                            </label></p>
                        <input id="name" type="text" name="name" placeholder="Jonathan"/>
                        <p class="general">
                            <label for="middle_name">Μεσαίο Όνομα
                            </label></p>
                        <input id="middle_name" type="text" name="middle_name" placeholder="P."/>
                        <p class="general">
                            <label for="surname">Επώνυμο <font color="red">*</font>
                            </label></p>
                        <input id="surname" type="text" name="surname" placeholder="Bradley"/>
                        <fieldset>
                            <label for="lessor">Εκμισθωτής
                            </label>
                            <input id="lessor" type="checkbox" value="1" name="lessor" />

                            <label for="seller">Πωλητής
                            </label>
                            <input id="seller" type="checkbox" value="1" name="seller" />

                            <label for="lessee">Ενοικιαστής
                            </label>
                            <input id="lessee" type="checkbox" value="1" name="lessee" />

                            <label for="buyer">Αγοραστής
                            </label>
                            <input id="buyer" type="checkbox" value="1" name="buyer" />
                        </fieldset>
                        <p class="general">
                            <label for="telephone1" > Τηλέφωνο
                            </label> </p>
                        <input id="telephone1"  type="text" name="telephone1" placeholder="2107777777" />
                        <p class="general">
                            <label for="telephone_2" > Τηλέφωνο 2
                            </label> </p>
                        <input id="telephone_2"  type="text" name="telephone_2"  placeholder="6977777777" />
                        <p class="general">
                            <label for="fax" > FAX
                            </label> </p>
                        <input id="fax"  type="text" name="fax"  />
                        <p class="general">
                            <label for="address1" > Διεύθυνση 1 <font color="red">*</font>
                            </label> </p>
                        <input id="address1"  type="text" name="address1"  placeholder="Μαρασλή 7"/>
                        <p class="general">
                            <label for="address2"> Διεύθυνση 2 
                            </label> </p>
                        <input id="address2" type="text" name="address2" />
                        <p class="general">
                            <label for="address3"> Διεύθυνση 3
                            </label></p>
                        <input id="address3" type="text" name="address3"  />
                        <p class="general">
                            <label for="city"> Πόλη <font color="red">*</font>
                            </label></p>
                        <input id="city" type="text" name="city" placeholder="Κολωνάκι"/>
                        <p class="general">
                            <label for="region"> Περιοχή <font color="red">*</font>
                            </label></p> 
                        <input id="region" type="text" name="region" placeholder="Αττική"/>
                        <p class="general">
                            <label for="postalCode"> Ταχυδρομικός Κώδικας <font color="red">*</font>
                            </label></p>
                        <input id="postalCode" type="text" name="postalCode" placeholder="10676"/>
                        <p class="general"><label for="country"> Χώρα <font color="red">*</font>
                            </label></p>
                            <% String[] locales = Locale.getISOCountries(); %>
                        <select id="country" name="country">
                            <%
                                for (String locale : locales) {
                                    Locale _locale = new Locale("", locale);
                                    if (_locale.getDisplayCountry().equals("Greece")) {
                                        out.println("<option selected value=\"" + _locale.getDisplayCountry() + "\">" + _locale.getDisplayCountry() + "</option>");
                                    } else {
                                        out.println("<option value=\"" + _locale.getDisplayCountry() + "\">" + _locale.getDisplayCountry() + "</option>");
                                    }
                                }
                            %>
                        </select>
                        <p><input class="buttom" name="submit" id="submit" value="Συνέχεια" type="submit"> </p>	 
                    </form>
                    <p>(<font color="red">*</font> Υποχρεωτικό Πεδίο)</p>
                </div>
            </div>
            <div class="onerow">
                <div class="col1">             
                    <a href="index.jsp"><img src="images/farfooter.png" alt="logo"/></a>
                </div>
                <div class="col3"><p><b>Find A Residence &copy;</b><br>Yποστήριξη Αποφάσεων Ενοικίασης/Αγοράς Κατοικίας</p></div>
                <div class="col4">             
                    <p><b>Υλοποιήθηκε από:</b><br/>Κωνσταντίνος Δαλιάνης - 1115201000178<br/>Φάβα Μαρία - 1115201000104</p>
                </div>
                <div class="col4 last">             
                    <p><a href="mailto:admin@far.gr?Subject=Find A Residence" target="_top">Επικοινωνήστε Μαζί μας</a></p>
                </div>
            </div> 
        </div> 
    </body>
</html>
