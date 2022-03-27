# template-toolbox

A templating system for MATLAB.

Based on
[Django template language](https://docs.djangoproject.com/en/4.0/ref/templates/language/).

## Installation steps

* Download [release/Template.mltbx](https://github.com/brhannan/template-toolbox/tree/main/release).
* Open MATLAB, navigate to Template.mltbx, and double-click on it.


## Examples

### Example 1: simple text operations

Enter the commands below in the MATLAB command window to render text
from a simple template.
````
eng = template.Engine;
eng.getTemplateFromText( ...
    '{% for k = 0:2 %} {{ 99 - k }} bottles of {{ beverage }} on the wall {% endfor %}');
eng.add('beverage', 'beer');
renderedText = eng.render
````
The output is
````
renderedText =
    '99 bottles of beer on the wall
     98 bottles of beer on the wall
     97 bottles of beer on the wall'
````

### Example 2: generate code

Create a file named addNoise.tmpl and paste the following text into it.
````
function out = addNoise(in)
{% comment %}
This template generates a function that adds Gaussian noise to the 
input. When isBiased is true, the function adds a bias equal to myVar.
{% endcomment %}
{% if {{ isBiased }} %}
    out = in + randn() + {{ myVar }};
{% else %}
    out = in + randn();
{% endif %}
end
````
In MATLAB, create a `template.Engine` object and configure it for code
generation. Call the `render` method to generate file myFunciton.m in the
current directory.
````
eng = template.Engine;
eng.OutputFile = 'addNoise.m'; % The name of the file to be generated.
eng.getTemplateFromFile('addNoise.tmpl');
eng.add('isBiased', true);
eng.add('myVar', 'pi');
eng.render
````
The contents of the generated file myFunction.m are
````
function out = addNoise(in)
out = in + randn() + pi;
end
````



## TODO

* Add function signatures json.
