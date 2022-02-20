classdef tTemplate < matlab.unittest.TestCase
   
   methods (Test)
       
       function testConstruct(~)
           template.Template();
       end
       
       function testConstructWithTemplateTextInput(~)
           template.Template('TemplateText', ...
               '{% if true %} hello world {% endif %}');
       end
       
       function testSetTemplateFileName(~)
           t = template.Template();
           % See /test/templates/testTemplate1.tmpl.
           t.FileName = 'testTemplate1.tmpl';
       end
       
       function testGetTemplateFromFile(testCase)
           t = template.Template();
           % See /test/templates/testTemplate1.tmpl.
           fileName = 'testTemplate1.tmpl';
           t.FileName = fileName;
           t.readFile();
           act = t.TemplateText;
           exp = 'The {{ theAnimal }} jumps over the {{ theObstacle }}.';
           testCase.verifyEqual(act, exp, ...
               ['Check that TemplateText property contains the ' ...
               'expected contents.']);
       end
       
       function testSimpleRender(testCase)
           t = template.Template('TemplateText', ...
               '{% if true %} hello world {% endif %}');
           ctxt = template.Context();
           t.render(ctxt);
           act = t.RenderedText;
           exp = 'hello world';
           testCase.verifyEqual(act, exp, ...
               sprintf( ...
                'Expected output text to be "%s". Instead it was "%s".',...
                exp, act));
       end
       
       function testSimpleRenderWithComment(testCase)
           t = template.Template('TemplateText', ...
               ['{% if true %} hello world {% endif %}', ...
               '{% comment %} this is a comment {% endcomment %}']);
           ctxt = template.Context();
           t.render(ctxt);
           act = t.RenderedText;
           exp = 'hello world';
           testCase.verifyEqual(act, exp, ...
               sprintf( ...
                'Expected output text to be "%s". Instead it was "%s".',...
                exp, act));
       end
       
       function testDanglingVariable(testCase)
           t = template.Template('TemplateText', ...
               ['{% if true %} hello world {% endif %}', ...
               ' {{ x }}']);
           ctxt = template.Context();
           ctxt.add('x', 'goodbye');
           t.render(ctxt);
           act = t.RenderedText;
           exp = 'hello world goodbye';
           testCase.verifyEqual(act, exp, ...
               sprintf( ...
                'Expected output text to be "%s". Instead it was "%s".',...
                exp, act));
       end
       
       % TODO: Implement if/elseif/else logic. The test below is intended
       % to fail until this feature has been implemented.
       function testIfElse(testCase)
           t = template.Template('TemplateText', ...
               ['{% if false %} good morning {% elseif %} ', ...
               'good night {% endif %}']);
           ctxt = template.Context();
           t.render(ctxt);
           act = t.RenderedText;
           exp = 'good night';
           testCase.verifyEqual(act, exp, ...
               sprintf( ...
                'Expected output text to be "%s". Instead it was "%s".',...
                exp, act));
       end
       
   end
   
end