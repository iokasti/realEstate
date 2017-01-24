(function($) {

    $.fn.menumaker = function(options) {

        var cssmenu = $(this), settings = $.extend({
            title: "Menu",
            format: "dropdown",
            sticky: false
        }, options);

        return this.each(function() {
            cssmenu.prepend('<div id="menu-button">' + settings.title + '</div>');
            $(this).find("#menu-button").on('click', function() {
                $(this).toggleClass('menu-opened');
                var mainmenu = $(this).next('ul');
                if (mainmenu.hasClass('open')) {
                    mainmenu.hide().removeClass('open');
                }
                else {
                    mainmenu.show().addClass('open');
                    if (settings.format === "dropdown") {
                        mainmenu.find('ul').show();
                    }
                }
            });

            cssmenu.find('li ul').parent().addClass('has-sub');

            multiTg = function() {
                cssmenu.find(".has-sub").prepend('<span class="submenu-button"></span>');
                cssmenu.find('.submenu-button').on('click', function() {
                    $(this).toggleClass('submenu-opened');
                    if ($(this).siblings('ul').hasClass('open')) {
                        $(this).siblings('ul').removeClass('open').hide();
                    }
                    else {
                        $(this).siblings('ul').addClass('open').show();
                    }
                });
            };

            if (settings.format === 'multitoggle')
                multiTg();
            else
                cssmenu.addClass('dropdown');

            if (settings.sticky === true)
                cssmenu.css('position', 'fixed');

            resizeFix = function() {
                if ($(window).width() > 768) {
                    cssmenu.find('ul').show();
                }

                if ($(window).width() <= 768) {
                    cssmenu.find('ul').hide().removeClass('open');
                }
            };
            resizeFix();
            return $(window).on('resize', resizeFix);

        });
    };
})(jQuery);

(function($) {
    $(document).ready(function() {

        $("#cssmenu").menumaker({
            title: "Menu",
            format: "multitoggle"
        });

    });
})(jQuery);


function toggle(div_id) {
    var el = document.getElementById(div_id);
    if (el.style.display === 'none') {
        el.style.display = 'block';
    }
    else {
        el.style.display = 'none';
    }
}
function blanket_size(popUpDivVar) {
    if (typeof window.innerWidth !== 'undefined') {
        viewportheight = window.innerHeight;
    } else {
        viewportheight = document.documentElement.clientHeight;
    }
    if ((viewportheight > document.body.parentNode.scrollHeight) && (viewportheight > document.body.parentNode.clientHeight)) {
        blanket_height = viewportheight;
    } else {
        if (document.body.parentNode.clientHeight > document.body.parentNode.scrollHeight) {
            blanket_height = document.body.parentNode.clientHeight;
        } else {
            blanket_height = document.body.parentNode.scrollHeight;
        }
    }
    var blanket = document.getElementById('blanket');
    blanket.style.height = blanket_height + 'px';
    var popUpDiv = document.getElementById(popUpDivVar);
    popUpDiv_height = blanket_height / 2 - 200;//200 is half popup's height
    popUpDiv.style.top = popUpDiv_height + 'px';
}
function window_pos(popUpDivVar) {
    if (typeof window.innerWidth !== 'undefined') {
        viewportwidth = window.innerHeight;
    } else {
        viewportwidth = document.documentElement.clientHeight;
    }
    if ((viewportwidth > document.body.parentNode.scrollWidth) && (viewportwidth > document.body.parentNode.clientWidth)) {
        window_width = viewportwidth;
    } else {
        if (document.body.parentNode.clientWidth > document.body.parentNode.scrollWidth) {
            window_width = document.body.parentNode.clientWidth;
        } else {
            window_width = document.body.parentNode.scrollWidth;
        }
    }
    var popUpDiv = document.getElementById(popUpDivVar);
    window_width = window_width / 2 - 200;//200 is half popup's width
    popUpDiv.style.left = window_width + 'px';
}
function popup(windowname) {
    blanket_size(windowname);
    window_pos(windowname);
    toggle('blanket');
    toggle(windowname);
}

function validateRegisterForm() {
    var x = document.forms["register-form"]["username"].value;
    if (x === null || x === "") {
        alert("Το Όνομα Χρήστη είναι κενό.");
        return false;
    }
    if (x.length < 3) {
        alert("Το Όνομα Χρήστη έχει μικρότερο από το επιτρεπτό μήκος.");
        return false;
    }
    if (x.length > 20) {
        alert("Το Όνομα Χρήστη έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var y = document.forms["register-form"]["password"].value;
    if (y === null || y === "") {
        alert("Ο Κωδικός είναι κενός");
        return false;
    }
    if (y.length < 5) {
        alert("Ο Κωδικός  έχει μικρότερο από το επιτρεπτό μήκος.");
        return false;
    }
    if (y.length > 15) {
        alert("Ο Κωδικός έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["register-form"]["password2"].value;
    if (x !== y) {
        alert("Ο Κωδικός Επιβεβαίωσης δεν αντιστοιχεί.");
        return false;
    }
    var x = document.forms["register-form"]["email"].value;
    if (x === null || x === "") {
        alert("Το Email είναι κενό");
        return false;
    }
    if (x.length > 254) {
        alert("Το Email έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var atpos = x.indexOf("@");
    var dotpos = x.lastIndexOf(".");
    if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) {
        alert("Μη έγκυρο Email.");
        return false;
    }
    var x = document.forms["register-form"]["name"].value;
    if (x === null || x === "") {
        alert("Το Όνομα είναι κενό.");
        return false;
    }
    if (x.length > 50) {
        alert("Το΄Όνομα έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["register-form"]["surname"].value;
    if (x === null || x === "") {
        alert("Το Επώνυμο είναι κενό.");
        return false;
    }
    if (x.length > 50) {
        alert("Το επώμυμο έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["register-form"]["address1"].value;
    if (x === null || x === "") {
        alert("Η Διεύθυνση 1 είναι κενή.");
        return false;
    }
    if (x.length > 64) {
        alert("Η Διεύθυνση 1 έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["register-form"]["city"].value;
    if (x === null || x === "") {
        alert("Η Πόλη είναι κενή.");
        return false;
    }
    if (x.length > 64) {
        alert("Η Πόλη έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["register-form"]["region"].value;
    if (x === null || x === "") {
        alert("Η Περιοχή είναι κενή");
        return false;
    }
    if (x.length > 64) {
        alert("Η Περιοχή έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["register-form"]["postalCode"].value;
    if (x === null || x === "") {
        alert("Ο Ταχυδρομικός Κώδικας είναι κενός");
        return false;
    }
    if (x.length > 8) {
        alert("Ο Ταχυδρομικός Κώδικας έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
}


function validateEditProfileForm() {
    var x = document.forms["form"]["email"].value;
    if (x === null || x === "") {
        alert("Το Email είναι κενό");
        return false;
    }
    if (x.length > 254) {
        alert("Το Email έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var atpos = x.indexOf("@");
    var dotpos = x.lastIndexOf(".");
    if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) {
        alert("Μη έγκυρο Email.");
        return false;
    }
    var x = document.forms["form"]["name"].value;
    if (x === null || x === "") {
        alert("Το Όνομα είναι κενό.");
        return false;
    }
    if (x.length > 50) {
        alert("Το΄Όνομα έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["form"]["surname"].value;
    if (x === null || x === "") {
        alert("Το Επώνυμο είναι κενό.");
        return false;
    }
    if (x.length > 50) {
        alert("Το επώμυμο έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["form"]["address1"].value;
    if (x === null || x === "") {
        alert("Η Διεύθυνση 1 είναι κενή.");
        return false;
    }
    if (x.length > 64) {
        alert("Η Διεύθυνση 1 έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["form"]["city"].value;
    if (x === null || x === "") {
        alert("Η Πόλη είναι κενή.");
        return false;
    }
    if (x.length > 64) {
        alert("Η Πόλη έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["form"]["region"].value;
    if (x === null || x === "") {
        alert("Η Περιοχή είναι κενή");
        return false;
    }
    if (x.length > 64) {
        alert("Η Περιοχή έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["form"]["postalCode"].value;
    if (x === null || x === "") {
        alert("Ο Ταχυδρομικός Κώδικας είναι κενός");
        return false;
    }
    if (x.length > 8) {
        alert("Ο Ταχυδρομικός Κώδικας έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
}

function validateChangePasswordForm() {
    var y = document.forms["form"]["oldpassword"].value;
    if (y === null || y === "") {
        alert("Ο Παλιός Κωδικός είναι κενός");
        return false;
    }
    if (y.length < 5) {
        alert("Ο Παλιός Κωδικός έχει μικρότερο από το επιτρεπτό μήκος.");
        return false;
    }
    if (y.length > 15) {
        alert("Ο Παλιός Κωδικός έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var y = document.forms["form"]["newpassword"].value;
    if (y === null || y === "") {
        alert("Ο Νέος Κωδικός είναι κενός");
        return false;
    }
    if (y.length < 5) {
        alert("Ο Νέος Κωδικός έχει μικρότερο από το επιτρεπτό μήκος.");
        return false;
    }
    if (y.length > 15) {
        alert("Ο Νέος Κωδικός έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["form"]["renewpassword"].value;
    if (x !== y) {
        alert("Ο Κωδικός Επιβεβαίωσης δεν είναι ίδιος με τον Νέο Κωδικό.");
        return false;
    }
}

function validateImages(thisform)
{
    with (thisform)
    {
        if (document.getElementById("picture1").value !== "") {
            if (validateFileExtension(picture1, new Array("jpg", "jpeg", "gif", "png")) === false)
            {
                alert("Μη αποδεκτός τύπος αρχείου.");
                return false;
            }
            if (validateFileSize(picture1, 1048576) === false)
            {
                alert("Μη αποδεκτό μέγεθος αρχείου.");
                return false;
            }
        }
        if (document.getElementById("picture2").value !== "") {

            if (validateFileExtension(picture2, new Array("jpg", "jpeg", "gif", "png")) === false)
            {
                alert("Μη αποδεκτός τύπος αρχείου.");
                return false;
            }
            if (validateFileSize(picture2, 1048576) === false)
            {
                alert("Μη αποδεκτό μέγεθος αρχείου.");
                return false;
            }
        }
        if (document.getElementById("picture3").value !== "") {

            if (validateFileExtension(picture3, new Array("jpg", "jpeg", "gif", "png")) === false)
            {
                alert("Μη αποδεκτός τύπος αρχείου.");
                return false;
            }
            if (validateFileSize(picture3, 1048576) === false)
            {
                alert("Μη αποδεκτό μέγεθος αρχείου.");
                return false;
            }
        }
        if (document.getElementById("picture4").value !== "") {

            if (validateFileExtension(picture4, new Array("jpg", "jpeg", "gif", "png")) === false)
            {
                alert("Μη αποδεκτός τύπος αρχείου.");
                return false;
            }
            if (validateFileSize(picture4, 1048576) === false)
            {
                alert("Μη αποδεκτό μέγεθος αρχείου.");
                return false;
            }
        }
        if (document.getElementById("picture5").value !== "") {

            if (validateFileExtension(picture5, new Array("jpg", "jpeg", "gif", "png")) === false)
            {
                alert("Μη αποδεκτός τύπος αρχείου.");
                return false;
            }
            if (validateFileSize(picture5, 1048576) === false)
            {
                alert("Μη αποδεκτό μέγεθος αρχείου.");
                return false;
            }
        }
    }
}


function validateImage(thisform)
{
    with (thisform)
    {
        if (validateFileExtension(picture, new Array("jpg", "jpeg", "gif", "png")) === false)
        {
            alert("Μη αποδεκτός τύπος αρχείου.");
            return false;
        }
        if (validateFileSize(picture, 1048576) === false)
        {
            alert("Μη αποδεκτό μέγεθος αρχείου.");
            return false;
        }
    }
}

function validateFileExtension(component, extns)
{
    var flag = 0;
    with (component)
    {
        var ext = value.substring(value.lastIndexOf('.') + 1);
        for (i = 0; i < extns.length; i++)
        {
            if (ext === extns[i])
            {
                flag = 0;
                break;
            }
            else
            {
                flag = 1;
            }
        }
        if (flag !== 0)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
}

function validateFileSize(component, maxSize)
{
    if (navigator.appName === "Microsoft Internet Explorer")
    {
        if (component.value)
        {
            var oas = new ActiveXObject("Scripting.FileSystemObject");
            var e = oas.getFile(component.value);
            var size = e.size;
        }
    }
    else
    {
        if (component.files[0] !== undefined)
        {
            size = component.files[0].size;
        }
    }
    if (size !== undefined && size > maxSize)
    {
        return false;
    }
    else
    {
        return true;
    }
}

function countdownindex(num) {
    if (num > 0) {
        setTimeout("countdownindex(" + (num - 1) + ")", 1000);
        document.getElementById("countdownindex").innerHTML = num + " δευτερόλεπτα";
    }
    if (num < 2) {
        document.getElementById("countdownindex").innerHTML = num + " δευτερόλεπτα";
    }
    if (num < 1) {
        window.location.replace("index.jsp");
        document.getElementById("countdownindex").innerHTML = num + " δευτερόλεπτα";
    }
}

function countdownregister(num) {
    if (num > 0) {
        setTimeout("countdownregister(" + (num - 1) + ")", 1000);
        document.getElementById("countdownregister").innerHTML = num + " δευτερόλεπτα";
    }
    if (num < 2) {
        document.getElementById("countdownregister").innerHTML = num + " δευτερόλεπτα";
    }
    if (num < 1) {
        window.location.replace("register.jsp");
        document.getElementById("countdownregister").innerHTML = num + " δευτερόλεπτα";
    }
}


function validatePropertyForm() {
    var x = document.forms["pform"]["price"].value;
    if (x === null || x === "") {
        alert("Δεν έχετε ορίσει Τιμή.");
        return false;
    }
    var x = document.forms["pform"]["maintenanceCharges"].value;
    if (x === null || x === "") {
        alert("Δεν έχετε ορίσει Έξοδα Συντήρησης.");
        return false;
    }
    var x = document.forms["pform"]["sqMeters"].value;
    if (x === null || x === "") {
        alert("Δεν έχετε ορίσει Τετραγωνικά Μέτρα.");
        return false;
    }
    var x = document.forms["pform"]["roomsNo"].value;
    if (x === null || x === "") {
        alert("Δεν έχετε ορίσει Αριθμό Δωματίων.");
        return false;
    }
    var x = document.forms["pform"]["address1"].value;
    if (x === null || x === "") {
        alert("Η Διεύθυνση 1 είναι κενή.");
        return false;
    }
    if (x.length > 64) {
        alert("Η Διεύθυνση 1 έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["pform"]["city"].value;
    if (x === null || x === "") {
        alert("Η Πόλη είναι κενή.");
        return false;
    }
    if (x.length > 64) {
        alert("Η Πόλη έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["pform"]["region"].value;
    if (x === null || x === "") {
        alert("Η Περιοχή είναι κενή");
        return false;
    }
    if (x.length > 64) {
        alert("Η Περιοχή έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
    var x = document.forms["pform"]["postalCode"].value;
    if (x === null || x === "") {
        alert("Ο Ταχυδρομικός Κώδικας είναι κενός");
        return false;
    }
    if (x.length > 8) {
        alert("Ο Ταχυδρομικός Κώδικας έχει μεγαλύτερο από το επιτρεπτό μήκος.");
        return false;
    }
}
