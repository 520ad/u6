var myTimer;
var timeOut = document.getElementById("timeOut");
var orderBody = document.getElementById("orderbody");
var orderId = document.getElementById("orderId").innerText;

function qrcodeTimeout() {
    orderBody.style.display = "none";
    timeOut.style.display = "";
}

function calculateTime(intDiff) {
    var day = Math.floor(intDiff / (60 * 60 * 24));
    var hour = Math.floor(intDiff / (60 * 60)) - (day * 24);
    var minute = Math.floor(intDiff / 60) - (day * 24 * 60) - (hour * 60);
    var second = Math.floor(intDiff) - (day * 24 * 60 * 60) - (hour * 60 * 60) - (minute * 60);
    return { day, hour, minute, second };
}

function timer(intDiff) {
    var hourShow = document.querySelector('#hour_show');
    var minuteShow = document.querySelector('#minute_show');
    var secondShow = document.querySelector('#second_show');

    function updateDisplay(hour, minute, second) {
        hourShow.innerHTML = `<s id="h"></s>${hour}时`;
        minuteShow.innerHTML = `<s></s>${minute}分`;
        secondShow.innerHTML = `<s></s>${second}秒`;
    }

    function checkExpiration(hour, minute, second) {
        if (hour <= 0 && minute <= 0 && second <= 0) {
            qrcodeTimeout();
            clearInterval(myTimer);
        }
    }

    var myTimer = setInterval(() => {
        var { hour, minute, second } = calculateTime(intDiff);
        minute = minute <= 9 ? '0' + minute : minute;
        second = second <= 9 ? '0' + second : second;
        updateDisplay(hour, minute, second);
        checkExpiration(hour, minute, second);
        intDiff--;
    }, 1000);
}

function check() {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "../../../api/index/checkOrder", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var data = JSON.parse(xhr.responseText);
            console.log("订单支付状态:", JSON.stringify(data));
            if (data.code == 1) {
                window.location.href = data.data;
            } else {
                if (data.data == "订单已过期") {
                    intDiff = 0;
                } else {
                    setTimeout(check, 1500);
                }
            }
        }
    };
    xhr.send("orderId=" + orderId);
}

timer(300);
check();