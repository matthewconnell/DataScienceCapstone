Text Prediction App
========================================================
author: Matthew Connell
date: March 14th, 2018
autosize: true

About the App
========================================================

 - This app uses an algorithm based on the Katz's Backoff Model of word prediction. 
It takes the most recent words and finds the four most likely next words.

 - When it cannot find any good words at all, it returns one of the top four most common words.

 - I left in swear words as they are legitimate words the people commonly use and I did not believe any children would be using this app.

 - "Stopwords" ('a', 'the', 'and', etc.) were included as I found they made for more realistic predictions.

 - Punctuation was also removed (except for apostrophes) 


Limitations and Next Steps
========================================================


 - The application has been built for speed. 
In the case of some n-gram searches, this will result some accuracy loss. 
This is due to the file size limitations.

 - Only 20% of the data was sampled and of that, the least common n-gram combinations were dropped from the table.
Furthermore, the build is currently only available for the English language.

 - The next steps would be to add another language. 
Russian or German would be the best choices as the data has already been made available as part of this project.

 - I would also like to try adding 5-gram and 6-gram tables to the app to see how much that improves accuracy.


Sources
========================================================


 - Grep expressions and making n-gram table: <a href> https://www.youtube.com/watch?v=0le0ijNVP5M</a>
 - Grep reference guide: <a href>https://ryanstutorials.net/linuxtutorial/cheatsheetgrep.php</a>
 - Buiding a better Shiny app: <a href>https://deanattali.com/blog/building-shiny-apps-tutorial/#1-before-we-begin</a>
 - Wordcloud: <a href>http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know</a>
 - Plot output: <a href>https://shiny.rstudio.com/reference/shiny/latest/plotOutput.html</a>
 - Shiny inputSelector: <a href>http://shiny.rstudio.com/gallery/selectize-vs-select.html</a>
 - Updating text input fields: <a href>https://shiny.rstudio.com/reference/shiny/latest/textAreaInput.html</a>
 - Dynamic buttons: <a href>https://sites.temple.edu/psmgis/2017/07/26/r-shiny-task-create-an-input-select-box-that-is-dependent-on-a-previous-input-choice/</a>",
 - Reactive variables: <a href>https://stackoverflow.com/questions/17002160/shiny-tutorial-error-in-r/17649022</a>
 - More sources can be found on the app's site
 




Animated List
========================================================

> 1. Point 1
> 2. Point 2
> 3. Point 3

 Motion Chart
========================================================


<!-- MotionChart generated in R 3.4.0 by googleVis 0.6.2 package -->
<!-- Wed Mar 14 18:22:46 2018 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataMotionChartID3ce02f8740f2 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
"Apples",
2008,
"West",
98,
78,
20,
"2008-12-31"
],
[
"Apples",
2009,
"West",
111,
79,
32,
"2009-12-31"
],
[
"Apples",
2010,
"West",
89,
76,
13,
"2010-12-31"
],
[
"Oranges",
2008,
"East",
96,
81,
15,
"2008-12-31"
],
[
"Bananas",
2008,
"East",
85,
76,
9,
"2008-12-31"
],
[
"Oranges",
2009,
"East",
93,
80,
13,
"2009-12-31"
],
[
"Bananas",
2009,
"East",
94,
78,
16,
"2009-12-31"
],
[
"Oranges",
2010,
"East",
98,
91,
7,
"2010-12-31"
],
[
"Bananas",
2010,
"East",
81,
71,
10,
"2010-12-31"
] 
];
data.addColumn('string','Fruit');
data.addColumn('number','Year');
data.addColumn('string','Location');
data.addColumn('number','Sales');
data.addColumn('number','Expenses');
data.addColumn('number','Profit');
data.addColumn('string','Date');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartMotionChartID3ce02f8740f2() {
var data = gvisDataMotionChartID3ce02f8740f2();
var options = {};
options["width"] = 600;
options["height"] = 500;
options["state"] = "";

    var chart = new google.visualization.MotionChart(
    document.getElementById('MotionChartID3ce02f8740f2')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "motionchart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartMotionChartID3ce02f8740f2);
})();
function displayChartMotionChartID3ce02f8740f2() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartMotionChartID3ce02f8740f2"></script>
 
<!-- divChart -->
  
<div id="MotionChartID3ce02f8740f2" 
  style="width: 600; height: 500;">
</div>
