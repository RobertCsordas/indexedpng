----------------------------------------------------------------------
--
-- Copyright (c) 2011 Ronan Collobert, Clement Farabet
--
-- Original package from "https://github.com/torch/image"
-- Modified by Robert Csordas to be able to load indexed PNGs.
--
-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
--
-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-- NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
-- LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
-- OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
-- WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--
----------------------------------------------------------------------
-- description:
--     Indexed PNG loader for torch.
--
-- history:
--     March 21, 2016 - Indexed image loader
--     July  1, 2011, 7:42PM - import from Torch5 - Clement Farabet
----------------------------------------------------------------------

require 'torch'
require 'sys'
require 'xlua'
require 'dok'
--require 'libimage'

----------------------------------------------------------------------
-- types lookups
--
local type2tensor = {
   float = torch.FloatTensor(),
   double = torch.DoubleTensor(),
   byte = torch.ByteTensor(),
}
local template = function(type)
   if type then
      return type2tensor[type]
   else
      return torch.Tensor()
   end
end

indexedpng={}

----------------------------------------------------------------------
-- save/load indexed PNG

local function loadPNG(filename, tensortype)
   if not xlua.require 'libpng_indexed' then
      dok.error('libpng package not found, please install libpng','indexedpng.loadPNG')
   end
   local load_from_file = 1

   local a, bit_depth = template(tensortype).libpng_indexed.load(load_from_file, filename)
   return a:view(a:size(2),-1)
end
rawset(indexedpng, 'loadPNG', loadPNG)

local function load(filename, tensortype)
   tensortype=tensortype or 'byte'
   if not filename then
      print(dok.usage('image.load',
                       'loads an image into a torch.Tensor', nil,
                       {type='string', help='path to file', req=true},
                       {type='string', help='type: byte | float | double'}))
      dok.error('missing file name', 'indexedpng.load')
   end

   return indexedpng.loadPNG(filename, tensortype)
end
rawset(indexedpng, 'load', load)

return indexedpng
