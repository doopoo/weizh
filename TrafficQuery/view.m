
#import "view.h"

@implementation view


-(void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    //建立一个颜色梯度对象
    CGGradientRef myGradient;
    CGColorSpaceRef myColorSpace;
    size_t locationCount = 3;
    CGFloat locationList[] = {0.0, 0.1, 1.0};
    CGFloat colorList[] = {
        1.0, 0.0, 0.5, 1.0, //red, green, blue, alpha
        1.0, 0.0, 1.0, 1.0,
        0.3, 0.5, 1.0, 1.0
    };
    myColorSpace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents(myColorSpace, colorList,
                                                     locationList, locationCount);//核心的函数就是这个，要搞清渐变一些量化的东西了。
    
    CGPoint startPoint, endPoint;
    startPoint.x = 0;
    startPoint.y = 0;
    endPoint.x = CGRectGetMaxX(self.bounds);
    endPoint.y = CGRectGetMaxY(self.bounds);
    CGContextDrawLinearGradient(context, myGradient, startPoint, endPoint,0);//这是绘制的，你可以通过裁剪来完成特定形状的过渡。
    CGColorSpaceRelease(myColorSpace);
    CGGradientRelease(myGradient);
}

@end
