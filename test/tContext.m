classdef tContext < matlab.unittest.TestCase
   
   methods (Test)
       
       function testConstruct(~)
           template.Context();
       end
       
       function testConstructMapInput(~)
           map = containers.Map;
           map('x') = 1;
           template.Context('Map', map);
       end
       
       function testAddToMapAndRetrieveValue(testCase)
           ctxt = template.Context();
           ctxt.add('myVar', 3);
           act = ctxt.at('myVar');
           exp = 3;
           testCase.verifyEqual(act, exp, ...
               'Expected entry myVar to have value 3.');
       end
       
       function testGetKeyset(testCase)
           ctxt = template.Context();
           ctxt.add('myVar1', 3);
           ctxt.add('myVar2', 4);
           act = ctxt.keys();
           exp = {'myVar1', 'myVar2'};
           testCase.verifyEqual(act, exp, ...
               'Check that keyset has the expected entries.');
       end
       
       function testRemoveMapEntry(testCase)
           ctxt = template.Context();
           ctxt.add('myVar', 3);
           ctxt.remove('myVar');
           keyset = ctxt.keys();
           testCase.verifyTrue( isempty(keyset), ...
               'Check for empty keyset after adding/removing a variable.');
       end
       
   end
   
end