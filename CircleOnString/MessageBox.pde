class MessageBox
{
  final static int RECT_MODE = 1;
  final static int ELLIPSE_MODE = 2;
  public float x;
  public float y;
  private float w;
  private float h;
  private String message;
  private int drawMode = RECT_MODE;
  private int horizontalAlign = LEFT;
  private int verticalAlign = TOP;

  MessageBox( float _x, float _y, float _w, float _h, String _msg ) {
    this(_x, _y, _w, _h, _msg, RECT_MODE);
  }
  MessageBox( float _x, float _y, float _w, float _h, String _msg, int _drawMode ) {
    this.x = _x;
    this.y = _y;
    this.w = _w;
    this.h = _h;
    this.message = _msg;
    this.drawMode = _drawMode;
  }

  void display() {
    noFill();
    stroke(0);
    textAlign(horizontalAlign, verticalAlign);
    ellipse(x, y, diameter, diameter);
    rect(rextX, rextY, rectSize, rectSize);
  }

  void update(float _x, float _y) {
    this.x = _x;
    this.y = _y;
  }

  void textAlign(int horizontal, int vertical) {
  }
  void setAlign() {
  }
  void setVertical() {
  }
  void getTextIntoEllipse()
  {
    Rect myRect = new Rect();
    // 短いほうの幅で正方形の形でやる
    float diameter = w;
    if(this.w > this.h)
      diameter = h / sqrt(2);
    float rectSize = diameter   / sqrt(2);
    float rectPosition = (diameter - rectSize) / 2.0;
    myRect.x = x - diameter/2.0 + rectPosition;
    myRect.y = y - diameter/2.0 + rectPosition;
    myRect.w = rectSize;
    myRect.h = rectSize;
    return myRect;

    switch(horizontalAlign)
    {
    case LEFT :
      textX = rextX;
      break;
    case CENTER :
      textX = x;
      break;
    case RIGHT :
      textX = rextX + rectSize;
      break;
    default :
      break;
    }
    switch(vertical)
    {
    case TOP :
      textY = rextY;
      break;
    case CENTER :
      textY = y + textSize * (multiLineText.length / 2.0 - 0.5 - ( multiLineText.length - 1 ));
      break;
    case BOTTOM :
      textY = rextY + rectSize - textSize * (multiLineText.length - 1);
      break;
    default :
      break;
    }
  }
}