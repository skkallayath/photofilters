import 'package:photofilters/filters/filters.dart';

// Clarendon: adds light to lighter areas and dark to darker areas
class ClarendonFilter extends Filter {
  ClarendonFilter() : super(name: "Clarendon") {
    subFilters.add(new BrightnessSubFilter(.1));
    subFilters.add(new ContrastSubFilter(.1));
    subFilters.add(new SaturationSubFilter(.15));
  }
}

// module.exports.clarendon = (pixels) => {
//   pixels = filters.brightness.apply(this, [pixels, 0.1]);
//   pixels = filters.contrast.apply(this, [pixels, 0.1]);
//   pixels = filters.saturation.apply(this, [pixels, 0.15]);
//   return pixels;
// };
// class F1977Filter extends Filter {
//   F1977Filter() : super(name: "F1977") {
//     subFilters.add(new ContrastSubFilter(110));
//     subFilters.add(new BrightnessSubFilter(110));
//     subFilters.add(new SaturationSubFilter(130));
//   }
// }
// // Gingham: Vintage-inspired, taking some color out
// module.exports.gingham = (pixels) => {
//   pixels = filters.sepia.apply(this, [pixels, 0.04]);
//   pixels = filters.contrast.apply(this, [pixels, -0.15]);
//   return pixels;
// };

// // Moon: B/W, increase brightness and decrease contrast
// module.exports.moon = (pixels) => {
//   pixels = filters.grayscale.apply(this, [pixels, 1]);
//   pixels = filters.contrast.apply(this, [pixels, -0.04]);
//   pixels = filters.brightness.apply(this, [pixels, 0.1]);
//   return pixels;
// };

// // Lark: Brightens and intensifies colours but not red hues
// module.exports.lark = (pixels) => {
//   pixels = filters.brightness.apply(this, [pixels, 0.08]);
//   pixels = filters.rgbAdjust.apply(this, [pixels, [1, 1.03, 1.05]]);
//   pixels = filters.saturation.apply(this, [pixels, 0.12]);
//   return pixels;
// };

// // Reyes: a new vintage filter, gives your photos a “dusty” look
// module.exports.reyes = (pixels) => {
//   pixels = filters.sepia.apply(this, [pixels, 0.4]);
//   pixels = filters.brightness.apply(this, [pixels, 0.13]);
//   pixels = filters.contrast.apply(this, [pixels, -0.05]);
//   return pixels;
// };

// // Juno: Brightens colors, and intensifies red and yellow hues
// module.exports.juno = (pixels) => {
//   pixels = filters.rgbAdjust.apply(this, [pixels, [1.01, 1.04, 1]]);
//   pixels = filters.saturation.apply(this, [pixels, 0.3]);
//   return pixels;
// };

// // Slumber: Desaturates the image as well as adds haze for a retro, dreamy look – with an emphasis on blacks and blues
// module.exports.slumber = (pixels) => {
//   pixels = filters.brightness.apply(this, [pixels, 0.1]);
//   pixels = filters.saturation.apply(this, [pixels, -0.5]);
//   return pixels;
// };

// // Crema: Adds a creamy look that both warms and cools the image
// module.exports.crema = (pixels) => {
//   pixels = filters.rgbAdjust.apply(this, [pixels, [1.04, 1, 1.02]]);
//   pixels = filters.saturation.apply(this, [pixels, -0.05]);
//   return pixels;
// };

// // Ludwig: A slight hint of desaturation that also enhances light
// module.exports.ludwig = (pixels) => {
//   pixels = filters.brightness.apply(this, [pixels, 0.05]);
//   pixels = filters.saturation.apply(this, [pixels, -0.03]);
//   return pixels;
// };

// // Aden: This filter gives a blue/pink natural look
// module.exports.aden = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [228, 130, 225, 0.13]]);
//   pixels = filters.saturation.apply(this, [pixels, -0.2]);
//   return pixels;
// };

// // Perpetua: Adding a pastel look, this filter is ideal for portraits
// module.exports.perpetua = (pixels) => {
//   pixels = filters.rgbAdjust.apply(this, [pixels, [1.05, 1.1, 1]]);
//   return pixels;
// };

// // Amaro: Adds light to an image, with the focus on the centre
// module.exports.amaro = (pixels) => {
//   pixels = filters.saturation.apply(this, [pixels, 0.3]);
//   pixels = filters.brightness.apply(this, [pixels, 0.15]);
//   return pixels;
// };

// // Mayfair: Applies a warm pink tone, subtle vignetting to brighten the photograph center and a thin black border
// module.exports.mayfair = (pixels) => {
//   filters.colorFilter.apply(this, [pixels, [230, 115, 108, 0.05]]);
//   filters.saturation.apply(this, [pixels, 0.15]);
//   return pixels;
// };

// // Rise: Adds a "glow" to the image, with softer lighting of the subject
// module.exports.rise = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [255, 170, 0, 0.1]]);
//   pixels = filters.brightness.apply(this, [pixels, 0.09]);
//   pixels = filters.saturation.apply(this, [pixels, 0.1]);
//   return pixels;
// };

// // Hudson: Creates an "icy" illusion with heightened shadows, cool tint and dodged center
// module.exports.hudson = (pixels) => {
//   pixels = filters.rgbAdjust.apply(this, [pixels, [1, 1, 1.25]]);
//   pixels = filters.contrast.apply(this, [pixels, 0.1]);
//   pixels = filters.brightness.apply(this, [pixels, 0.15]);
//   return pixels;
// };

// // Valencia: Fades the image by increasing exposure and warming the colors, to give it an antique feel
// module.exports.valencia = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [255, 225, 80, 0.08]]);
//   pixels = filters.saturation.apply(this, [pixels, 0.1]);
//   pixels = filters.contrast.apply(this, [pixels, 0.05]);
//   return pixels;
// };

// // X-Pro II: Increases color vibrance with a golden tint, high contrast and slight vignette added to the edges
// module.exports.xpro2 = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [255, 255, 0, 0.07]]);
//   pixels = filters.saturation.apply(this, [pixels, 0.2]);
//   pixels = filters.contrast.apply(this, [pixels, 0.15]);
//   return pixels;
// };

// // Sierra: Gives a faded, softer look
// module.exports.sierra = (pixels) => {
//   pixels = filters.contrast.apply(this, [pixels, -0.15]);
//   pixels = filters.saturation.apply(this, [pixels, 0.1]);
//   return pixels;
// };

// // Willow: A monochromatic filter with subtle purple tones and a translucent white border
// module.exports.willow = (pixels) => {
//   pixels = filters.grayscale.apply(this, [pixels, 1]);
//   pixels = filters.colorFilter.apply(this, [pixels, [100, 28, 210, 0.03]]);
//   pixels = filters.brightness.apply(this, [pixels, 0.1]);
//   return pixels;
// };

// // Lo-Fi: Enriches color and adds strong shadows through the use of saturation and "warming" the temperature
// module.exports.lofi = (pixels) => {
//   pixels = filters.contrast.apply(this, [pixels, 0.15]);
//   pixels = filters.saturation.apply(this, [pixels, 0.2]);
//   return pixels;
// };

// // Inkwell: Direct shift to black and white
// module.exports.inkwell = (pixels) => {
//   pixels = filters.grayscale.apply(this, [pixels, 1]);
//   return pixels;
// };

// // Hefe: Hight contrast and saturation, with a similar effect to Lo-Fi but not quite as dramatic
// module.exports.hefe = (pixels) => {
//   pixels = filters.contrast.apply(this, [pixels, 0.1]);
//   pixels = filters.saturation.apply(this, [pixels, 0.15]);
//   return pixels;
// };

// // Nashville: Warms the temperature, lowers contrast and increases exposure to give a light "pink" tint – making it feel "nostalgic"
// module.exports.nashville = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [220, 115, 188, 0.12]]);
//   pixels = filters.contrast.apply(this, [pixels, -0.05]);
//   return pixels;
// };

// // Stinson: washing out the colors ever so slightly
// module.exports.stinson = (pixels) => {
//   pixels = filters.brightness.apply(this, [pixels, 0.1]);
//   pixels = filters.sepia.apply(this, [pixels, 0.3]);
//   return pixels;
// };

// // Vesper: adds a yellow tint that
// module.exports.vesper = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [255, 225, 0, 0.05]]);
//   pixels = filters.brightness.apply(this, [pixels, 0.06]);
//   pixels = filters.contrast.apply(this, [pixels, 0.06]);
//   return pixels;
// };

// // Earlybird: Gives an older look with a sepia tint and warm temperature
// module.exports.earlybird = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [255, 165, 40, 0.2]]);
//   return pixels;
// };

// // Brannan: Increases contrast and exposure and adds a metallic tint
// module.exports.brannan = (pixels) => {
//   pixels = filters.contrast.apply(this, [pixels, 0.2]);
//   pixels = filters.colorFilter.apply(this, [pixels, [140, 10, 185, 0.1]]);
//   return pixels;
// };

// // Sutro: Burns photo edges, increases highlights and shadows dramatically with a focus on purple and brown colors
// module.exports.sutro = (pixels) => {
//   pixels = filters.brightness.apply(this, [pixels, -0.1]);
//   pixels = filters.saturation.apply(this, [pixels, -0.1]);
//   return pixels;
// };

// // Toaster: Ages the image by "burning" the centre and adds a dramatic vignette
// module.exports.toaster = (pixels) => {
//   pixels = filters.sepia.apply(this, [pixels, 0.1]);
//   pixels = filters.colorFilter.apply(this, [pixels, [255, 145, 0, 0.2]]);
//   return pixels;
// };

// // Walden: Increases exposure and adds a yellow tint
// module.exports.walden = (pixels) => {
//   pixels = filters.brightness.apply(this, [pixels, 0.1]);
//   pixels = filters.colorFilter.apply(this, [pixels, [255, 255, 0, 0.2]]);
//   return pixels;
// };

// // 1977: The increased exposure with a red tint gives the photograph a rosy, brighter, faded look.
// module.exports['1977'] = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [255, 25, 0, 0.15]]);
//   pixels = filters.brightness.apply(this, [pixels, 0.1]);
//   return pixels;
// };

// // Kelvin: Increases saturation and temperature to give it a radiant "glow"
// module.exports.kelvin = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [255, 140, 0, 0.1]]);
//   pixels = filters.rgbAdjust.apply(this, [pixels, [1.15, 1.05, 1]]);
//   pixels = filters.saturation.apply(this, [pixels, 0.35]);
//   return pixels;
// };

// // Maven: darkens images, increases shadows, and adds a slightly yellow tint overal
// module.exports.maven = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [225, 240, 0, 0.1]]);
//   pixels = filters.saturation.apply(this, [pixels, 0.25]);
//   pixels = filters.contrast.apply(this, [pixels, 0.05]);
//   return pixels;
// };

// // Ginza: brightens and adds a warm glow
// module.exports.ginza = (pixels) => {
//   filters.sepia.apply(this, [pixels, 0.06]);
//   filters.brightness.apply(this, [pixels, 0.1]);
//   return pixels;
// };

// // Skyline: brightens to the image pop
// module.exports.skyline = (pixels) => {
//   pixels = filters.saturation.apply(this, [pixels, 0.35]);
//   pixels = filters.brightness.apply(this, [pixels, 0.1]);
//   return pixels;
// };

// // Dogpatch: increases the contrast, while washing out the lighter colors
// module.exports.dogpatch = (pixels) => {
//   pixels = filters.contrast.apply(this, [pixels, 0.15]);
//   pixels = filters.brightness.apply(this, [pixels, 0.1]);
//   return pixels;
// };

// // Brooklyn
// module.exports.brooklyn = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [25, 240, 252, 0.05]]);
//   pixels = filters.sepia.apply(this, [pixels, 0.3]);
//   return pixels;
// };

// // Helena: adds an orange and teal vibe
// module.exports.helena = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [208, 208, 86, 0.2]]);
//   pixels = filters.contrast.apply(this, [pixels, 0.15]);
//   return pixels;
// };

// // Ashby: gives images a great golden glow and a subtle vintage feel
// module.exports.ashby = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [255, 160, 25, 0.1]]);
//   pixels = filters.brightness.apply(this, [pixels, 0.1]);
//   return pixels;
// };

// // Charmes: a high contrast filter, warming up colors in your image with a red tint
// module.exports.charmes = (pixels) => {
//   pixels = filters.colorFilter.apply(this, [pixels, [255, 50, 80, 0.12]]);
//   pixels = filters.contrast.apply(this, [pixels, 0.05]);
//   return pixels;
// };