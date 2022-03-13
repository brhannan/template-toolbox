# template-toolbox

A templating system for MATLAB.

Based on 
[Django template language](https://docs.djangoproject.com/en/4.0/ref/templates/language/).

## Setup

* Download /release/Template.mltbx.
* Open MATLAB, navigate to Template.mltbx, and double-click on it.


## Examples

### Example 1: simple text operations.

Enter the commands below in the MATLAB command window to render text 
from a simple template.
````
eng = template.Engine;
eng.getTemplateFromText('The {{ theAnimal }} jumps over the {{ theObstacle }}.');
eng.add('theAnimal','fox');
eng.add('theObstacle','log');
renderedText = eng.render
````

### Example 2: generate code.

Create a file myTemplate.tmpl and insert the following text into it.
````
function out = myFunction(in)
{% if {{ doMultiplication}} %}
    out = {{ myVar }} * in;
{% else %}
    out = {{ myVar }} + in;
{% endif %}
end
````
In MATLAB, create a `template.Engine` object and configure it for code 
generation. Call the `render` method to generate file myFunciton.m in the 
current directory.
````
eng = template.Engine;
eng.OutputFile = 'myFunction.m'; % The file to be generated.
eng.getTemplateFromFile('myTemplate.tmpl');
eng.add('myVar', 'pi');
eng.add('doMultiplication', true);
eng.render
````




## TODO

* Add function signatures json.
* Investigate {% comment %} block bug.
