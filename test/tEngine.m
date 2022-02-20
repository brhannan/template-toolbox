classdef tEngine < matlab.unittest.TestCase
   
   methods (Test)
       
       % Test basic map operations.
       
       function testAddVar(testCase)
           eng = template.Engine();
           eng.add('myVar', 'hello');
           act = eng.at('myVar');
           exp = 'hello';
           testCase.verifyEqual(act, exp, ...
               'Check that added variable has expected value.');
       end
       
       function testAddAndRemoveVar(testCase)
           eng = template.Engine();
           eng.add('myVar', 'hello');
           eng.remove('myVar');
           keys = eng.keys();
           testCase.verifyTrue(isempty(keys), ...
               'Check that keyset is empty after all keys removed.');
       end
       
       function testIsKey(testCase)
           eng = template.Engine();
           eng.add('myVar', 'hello');
           testCase.verifyTrue(eng.isKey('myVar'), ...
               'Check isKey() standard use.');
       end
       
       
       % Test render functionality.
       
       function testRenderSimpleIfTag(testCase)
           tagText = '{% if true %} hello world {% endif %}';
           eng = template.Engine();
           eng.getTemplateFromText(tagText);
           eng.render();
           act = eng.RenderedText;
           exp = 'hello world';
           testCase.verifyEqual(act, exp, ...
               sprintf(['Expected RenderedText to equal "%s". ' ...
               'Instead it was "%s".'], act, exp));
       end
       
   end
   
end