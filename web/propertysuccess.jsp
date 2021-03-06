<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Files"%>
<%@page import="javax.script.Invocable"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="javax.script.ScriptEngine"%>
<%@page import="javax.script.ScriptEngineManager"%>
<%@page import="service.UserIO"%>
<%@page import="java.util.List"%>
<%@page import="entities.User"%>
<%@page import="misc.IP_Functions"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script src="javascript/scripts.js" type="text/javascript"></script>
        <script>countdownindex(10);</script>
        <title>Find A Residence - Επιτυχής Προσθήκη Ιδιοκτησίας</title>	
    </head>
    <body> 
        <%
            User user = (User) session.getAttribute("user");
            if (user == null) {
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
                            <li><a href='#'><%=user.getName()%></a>
                                <ul>
                                    <li><a href='myproperties.jsp'>Οι Ιδιοκτησίες Μου</a></li>
                                    <li><a href='editprofile.jsp'>Επεξεργασία Προφίλ</a></li>
                                    <li><a href='logout.jsp'>Έξοδος</a></li>
                                </ul></li>
                                <%if (user.isLessor() || user.isSeller()) {%>
                            <li><a href='addproperty.jsp'>Καταχώρηση Ιδιοκτησίας</a></li>
                                <%}%>
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
                <div class="col2"></div>
                <div class="col8">
                    <p>Η ιδιοκτησία σας έχει καταχωρηθεί με επιτυχία!<br/>
                        Μπορείτε να δείτε λεπτομέρειες σχετικά με τις ιδιοκτησίες σας στη σελίδα <a href="myproperties.jsp">Διαχείρισης Ιδιοκτησιών</a>
                    </p>
                    <p>
                        Μένουν <span id="countdownindex">10 δευτερόλεπτα</span> για ανακατεύθυνση στην 
                        <a href="index.jsp"> Αρχική σελίδα</a>.</p>
                </div>
                <div class="col2 last"></div>
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