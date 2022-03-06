# template-toolbox
A templating system for MATLAB.

## Example

Create a file myTemplate.tmpl and insert the following text into it.
````
The {{ theAnimal }} jumps over the {{ theObstacle }}.
````
Enter the following MATLAB commands.
````
eng = template.Engine;
eng.getTemplateFromFile('myTemplate.tmpl');
eng.add('theAnimal','fox');
eng.add('theObstacle','log');
renderedText = eng.render
````


Based on 
[Django template language](https://docs.djangoproject.com/en/4.0/ref/templates/language/).

## TODO
[ ] Add support for elseif.
[ ] Add file write method to Engine.
