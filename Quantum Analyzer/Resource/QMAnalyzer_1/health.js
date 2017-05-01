/**
 * Created by wangkaili on 2017/4/16.
 */
function draw(a,color,canvas) {
    var fontSize = document.documentElement.style.fontSize.replace("px","");
    var s = canvas.getContext("2d");
    //贝兹曲线
    var start = 1.2*(fontSize)*2;
    console.log(start);
    console.log(document.documentElement.style.fontSize)
    s.beginPath();
    s.strokeStyle=color;
    s.lineWidth = 3;
    s.moveTo(0,start);
    var end = 2.3*(fontSize)*2;
    s.quadraticCurveTo(60,40,end,a);
    s.stroke();
}

function BigDraw(a,color,canvas) {
    var s = canvas.getContext("2d");
    //贝兹曲线
    s.beginPath();
    s.strokeStyle=color;
    s.lineWidth = 5;
    s.moveTo(0,0);
    s.quadraticCurveTo(canvas.width/3,canvas.height/4,a,canvas.height);
    s.stroke();
}
(function (doc, win) {
    var docEl = doc.documentElement,
        resizeEvt = 'orientationchange' in win ? 'orientationchange' : 'resize',
        recalc = function () {
            var clientWidth = docEl.clientWidth;
            if (!clientWidth) return;
            docEl.style.fontSize = (clientWidth >= 640 ? 100 : clientWidth / 6.4) + 'px';
        };

    if (!doc.addEventListener) return;
    win.addEventListener(resizeEvt, recalc, false);
    doc.addEventListener('DOMContentLoaded', recalc, false);
})(document, window);

var content = document.getElementById("content");
for(var i=0;i<data.length;i++){
    var dataLine = document.createElement("li");
    content.appendChild(dataLine);
    dataLine.innerHTML = '<canvas  class="canvas"></canvas>' +
        '<span class="name">'+data[i].name+'</span>'+
        '<span class="result">'+data[i].result+'</span>'+
        '<span class="abnormal_min">'+data[i].abnormal_min+'</span>' +
        '<span class="normal_min">'+data[i].normal_min+'</span>' +
        '<span class="normal_max">'+data[i].normal_max+'</span>'+
        '<span class="reality">'+data[i].reality+'</span>'+
        '<span class="abnormal_max">'+data[i].abnormal_max+'</span>'

}
window.onload = function(){
    console.log(22222222222222222);
    var fontSize = document.documentElement.style.fontSize.replace("px","");
    var canvases = document.getElementsByClassName("canvas");

    var lis = document.getElementsByTagName("li");
    for(var i=0;i<data.length;i++){
        var alone = data[i];
        var color,length,coord,bigCoord;
        color = alone.resultColor;

        //颜色
        <!--                if(alone.result=="正常"){-->
        <!--                    color = "lawngreen";-->
        <!--                }else if(alone.result=="轻度异常") {-->
        <!--                    color = "steelblue";-->
        <!--                }else if(alone.result=="中度异常") {-->
        <!--                    color = "darkgoldenrod";-->
        <!--                }else {-->
        <!--                    color = "red";-->
        <!--                }-->

        //高度
//                console.log(alone.reality)
//                console.log(alone.reality)
        if (alone.reality<alone.normal_min) {
            length = 2.4*fontSize-(alone.reality-alone.abnormal_min)/(alone.normal_min-alone.abnormal_min)*0.7*fontSize;
            coord = 0.9*fontSize;
            bigCoord = 2.68*fontSize;
            console.log(bigCoord)
        }else if (alone.reality<alone.normal_max) {
            length = 1.7*fontSize-(alone.reality-alone.normal_min)/(alone.normal_max-alone.normal_min)*0.8*fontSize;
            coord = 0.5*fontSize;
            bigCoord = 1.35*fontSize;
            console.log(bigCoord)
        }else if (alone.reality<alone.abnormal_max) {
            length = 0.9*fontSize-(alone.reality-alone.normal_max)/(alone.abnormal_max-alone.normal_max)*35;
            coord = 0.1*fontSize;
            bigCoord = 0.02*fontSize;
            console.log(bigCoord)
        }

        var canvas = canvases[i];
        canvas.width = 2.3*2*fontSize;
        canvas.height = 1.2*2*fontSize;
        draw(40,"green",canvas);
        draw(length,color,canvas);

        var reality = (lis[i].childNodes)[6];
        console.log(result);
        console.log(coord);
        reality.style.top = coord+"px";
        reality.style.color = color;
        var result = (lis[i].childNodes)[2];
        result.style.color = color;
        var box = document.getElementById("box");
        lis[i].index = i;
        lis[i].length = length;
        lis[i].color = color;
        lis[i].bigCoord = bigCoord;
        lis[i].onclick = function(){
            box.style.display = "block";
//                    box.style.width = "100%";
//                    box.style.height = "100%";
            var boxTop = document.body.scrollTop;
            box.style.top = boxTop+"px";
            box.innerHTML = '<div class="container">'+
                '<canvas class="bigCanvas"></canvas>' +
                '<span class="bigName">'+data[this.index].name+'</span>'+

                '<span class="bigResult">'+data[this.index].result+'</span>'+
                '<span class="bigAbnormal_min">'+data[this.index].abnormal_min+'</span>' +
                '<span class="bigNormal_min">'+data[this.index].normal_min+'</span>' +
                '<span class="bigNormal_max">'+data[this.index].normal_max+'</span>'+
                '<span class="bigReality">'+data[this.index].reality+'</span>'+
                '<span class="bigAbnormal_max">'+data[this.index].abnormal_max+'</span>'+
                '</div>';
            var bigcanvas = document.getElementsByClassName("bigCanvas");
            console.log(bigcanvas);
            var bigRealitys = document.getElementsByClassName("bigReality");
            var bigResults = document.getElementsByClassName("bigResult");
            var bigReality = bigRealitys[0];
            var bigResult = bigResults[0];
            bigReality.style.right = this.bigCoord;
            console.log(this.bigCoord);
//                    bigReality.style.top = bigCoord;
            bigReality.style.color = data[this.index].resultColor;
            bigResult.style.color = data[this.index].resultColor;
            var canvas1 = bigcanvas[0];
            canvas1.width = 4*2*fontSize;
            canvas1.height = 8.34*2*fontSize;
            BigDraw(canvas1.width*2/3,"green",canvas1);
            BigDraw(canvas1.width-canvas1.width*this.length/(1.2*2*fontSize),this.color,canvas1);

        }

    }


    document.addEventListener('touchmove', function(event) {
        if(box.style.display=="block"){
            event.preventDefault();
        }
    })
    box.onclick = function(){
        box.style.display = "none"
        box.innerHTML = "";
    }


}
