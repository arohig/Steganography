PImage cover;
PImage secret;
PImage encodedImage;
PImage decodedImage;

void setup()
{
  println("The encoded image has the cover image titled \"Cover Image.jpg\" and secret image titled \"Secret Image.jpg\".");
  println("To display the encoded image, press the key 'e' on your keyboard. To display the decoded image, press the key 'd' on your keyboard.");
  println("The encoded image will be saved as \"Encoded Image.jpg\" and the decoded image as \"Decoded Image.jpg\"");
  println("You can also view the cover image by typing 'c' or the secret image by typing 's'.");
  
  cover = loadImage("Cover Image.jpg");
  secret = loadImage("Secret Image.jpg");
  
  size(496, 330);
  encodedImage = createImage(cover.width,cover.height, RGB);
  decodedImage = createImage(cover.width,cover.height, RGB);
  
  int[][] coverPixel = new int[cover.width][cover.height];
  int[][] secretPixel = new int[secret.width][secret.height];

  // to encode
  int curSecRedNum, curSecGreenNum, curSecBlueNum, curCovRedNum, curCovGreenNum, curCovBlueNum;
  encodedImage.loadPixels();
  for (int x = 0; x < cover.width; x++)
  {
    for (int y = 0; y < cover.height; y++)
    {
      coverPixel[x][y] = cover.get(x, y);
      secretPixel[x][y] = secret.get(x, y);
      curSecRedNum = (int) red(secretPixel[x][y]);
      curSecGreenNum = (int) green(secretPixel[x][y]);;
      curSecBlueNum = (int) blue(secretPixel[x][y]);;
      curCovRedNum = (int) red(coverPixel[x][y]);
      curCovGreenNum = (int) green(coverPixel[x][y]);
      curCovBlueNum = (int) blue(coverPixel[x][y]);
      int newNum;
      if (curSecRedNum >= 128 && curSecRedNum <= 255)
      {
        curSecRedNum = 1;
        newNum = ( (Integer.parseInt(Integer.toString(curCovRedNum, 2)))/10 );
        curCovRedNum = Integer.parseInt((Integer.toString(newNum) + curSecRedNum), 2);
      }
      else
      {
        curSecRedNum = 0;
        newNum = ( (Integer.parseInt(Integer.toString(curCovRedNum, 2)))/10 );
        curCovRedNum = Integer.parseInt((Integer.toString(newNum) + curSecRedNum), 2);
      }
      
      if (curSecGreenNum >= 128 && curSecGreenNum <= 255)
      {
        curSecGreenNum = 1;
        newNum = ( (Integer.parseInt(Integer.toString(curCovGreenNum, 2)))/10 );
        curCovGreenNum = Integer.parseInt((Integer.toString(newNum) + curSecGreenNum), 2);
      }
      else
      {
        curSecGreenNum = 0;
        newNum = ( (Integer.parseInt(Integer.toString(curCovGreenNum, 2)))/10 );
        curCovGreenNum = Integer.parseInt((Integer.toString(newNum) + curSecGreenNum), 2);
      }
      
      if (curSecBlueNum >= 128 && curSecBlueNum <= 255)
      {
        curSecBlueNum = 1;
        newNum = ( (Integer.parseInt(Integer.toString(curCovBlueNum, 2)))/10 );
        curCovBlueNum = Integer.parseInt((Integer.toString(newNum) + curSecBlueNum), 2);
      }
      else
      {
        curSecBlueNum = 0;
        newNum = ( (Integer.parseInt(Integer.toString(curCovBlueNum, 2)))/10 );
        curCovBlueNum = Integer.parseInt((Integer.toString(newNum) + curSecBlueNum), 2);
      }
      
      encodedImage.pixels[x + (y*cover.width)] = color(curCovRedNum, curCovGreenNum, curCovBlueNum);
    } 
  }
  encodedImage.updatePixels();
  
  // to decode
  decodedImage.loadPixels();
  for (int x = 0; x < encodedImage.width; x++)
  {
    for (int y = 0; y < encodedImage.height; y++)
    {
      int encodedRedValue = (int) red(encodedImage.get(x, y));
      int encodedGreenValue = (int) green(encodedImage.get(x, y));
      int encodedBlueValue = (int) blue(encodedImage.get(x, y));
      
      String redString = Integer.toString(encodedRedValue, 2);
      String greenString = Integer.toString(encodedGreenValue, 2);
      String blueString = Integer.toString(encodedBlueValue, 2);
      
      int encodedRedSecretValue = Integer.parseInt(redString.substring(redString.length() - 1));
      int encodedGreenSecretValue = Integer.parseInt(greenString.substring(greenString.length() - 1));
      int encodedBlueSecretValue = Integer.parseInt(blueString.substring(blueString.length() - 1));
      
      int decodedRedSecretValue, decodedGreenSecretValue, decodedBlueSecretValue;
      
      if (encodedRedSecretValue == 0)
      {
        decodedRedSecretValue = 70;
      }
      else
      {
        decodedRedSecretValue = 180;
      }
        
      if (encodedGreenSecretValue == 0)
      {
        decodedGreenSecretValue = 70;
      }
      else
      {
        decodedGreenSecretValue = 180;
      }
        
      if (encodedBlueSecretValue == 0)
      {
        decodedBlueSecretValue = 70;
      }
      else
      {
        decodedBlueSecretValue = 180;
      }
      decodedImage.pixels[x + (y*encodedImage.width)] = color(decodedRedSecretValue, decodedGreenSecretValue, decodedBlueSecretValue);
    }
  }
  decodedImage.updatePixels();
}

void draw()
{
  if (key == 'd')
  {
    save("Decoded Image.jpg");
    image(decodedImage, 0, 0);
  }
  else if (key == 'e')
  {
    save("Encoded Image.jpg");
    image(encodedImage, 0, 0);
  }
  else if (key == 'c')
  {
    image(cover, 0, 0);
  }
  else if (key == 's')
  {
    image(secret, 0, 0);
  }
}
