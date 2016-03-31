# indexedpng Reference Manual #

__indexedpng__ is a [Torch7 distribution](http://torch.ch/) package for loading palette indexed PNG images. It returns the indexes directly without converting it to RGB (it completely ignores the palette). It is useful for loading the segmentation when learning fully convolutional segmentation netwroks.

It is heavily based on [Torch image toolbox](https://github.com/torch/image).

## Usage

```lua
> require 'indexedpng'
> l = indexedpng.load("test.png", 'byte')
```           
