classdef tTag < matlab.unittest.TestCase
   
   methods (Test)
       
       % Test that tag type is correctly identified.
       
       function testTagTypeIf(testCase)
           % Assert that isIf() output is correct after parsing an IF tag.
           tagText = '{% if true %} hello world {% endif %}';
           t = template.Tag(tagText);
           ctxt = template.Context();
           t.render(ctxt);
           testCase.verifyTrue(t.isIf(), ...
               'Expected isIf() to return true.');
       end

       function testTagTypeFor(testCase)
           % Assert that isFor() output is correct after parsing a FOR tag.
           tagText = '{% for k = 1:2 %} hello world {% endfor %}';
           t = template.Tag(tagText);
           ctxt = template.Context();
           t.render(ctxt);
           testCase.verifyTrue(t.isFor(), ...
               'Expected isFor() to return true.');
       end
       
       function testTagTypeComment(testCase)
           % Assert that isComment() output is correct after parsing a 
           % COMMENT tag.
           tagText = '{% comment %} hello world {% endcomment %}';
           t = template.Tag(tagText);
           ctxt = template.Context();
           t.render(ctxt);
           testCase.verifyTrue(t.isComment(), ...
               'Expected isComment() to return true.');
       end
       
       
       % Test rendered text.
       
       function testRenderedTextSimpleIf(testCase)
           % Assert that Body is correct after parsing a simple IF tag.
           tagText = '{% if true %} hello world {% endif %}';
           t = template.Tag(tagText);
           ctxt = template.Context();
           t.render(ctxt);
           exp = 'hello world';
           testCase.verifyEqual(t.RenderedText, exp, ...
               sprintf(['Expected RenderedText property to equal ' ...
               '"%s". instead it was "%s".'], exp, t.RenderedText));
       end
       
       function testRenderedTextSimpleFor(testCase)
           % Assert that Body is correct after parsing a simple FOR tag.
           tagText = '{% for k = 1:2 %} hello world {% endfor %}';
           t = template.Tag(tagText);
           ctxt = template.Context();
           t.render(ctxt);
           exp = sprintf('%s\n%s','hello world','hello world');
           testCase.verifyEqual(t.RenderedText, exp, ...
               sprintf(['Expected RenderedText property to equal ' ...
               '"%s". instead it was "%s".'], exp, t.RenderedText));
       end
       
       
       function testRenderedTextComment(testCase)
           % Check rendered output for a simple IF tag.
           tagText = '{% comment %} hello world {% endcomment %}';
           t = template.Tag(tagText);
           ctxt = template.Context();
           t.render(ctxt);
           exp = '';
           testCase.verifyEqual(t.RenderedText, exp, ...
               sprintf(['Expected RenderedText property to equal ' ...
               '"%s". instead it was "%s".'], exp, t.RenderedText));
       end
       
       % Test if/else handling.
       
       %-------------------------------------------------------------------
       % Note: the test below is expected to fail b/c if/else has not been
       % implemented yet.
       %-------------------------------------------------------------------
       
       function testSimpleIfElse(testCase)
           % Provide a simple if/else and verify that it was correctly
           % processed.
           tagText = '{% if false %} x {% else %} y {% endif %}';
           t = template.Tag(tagText);
           ctxt = template.Context();
           t.render(ctxt);
           exp = 'y';
           testCase.verifyEqual(t.RenderedText, exp, ...
           sprintf(['Expected RenderedText property to equal ' ...
               '"%s". instead it was "%s".'], exp, t.RenderedText));
       end
       
   end
   
end