classdef drawInput < handle
    %DRAWINPUT Class that allows you to draw with mouse on an image

    
    properties
        pictureSize; %size of picture
        inputPicture; %input picture where use draws
        mouseDown; %whether mous is down or not
        windowSize; %size of input window
        windowOpen; %whether a window is open or not
    end
    
    methods
        function obj = drawInput()
            %Constructor
            obj.pictureSize = 28;
            obj.inputPicture = 255 * ones(obj.pictureSize, obj.pictureSize, 'uint8');
            obj.mouseDown = false;
            obj.windowSize = 300;
            obj.windowOpen = false;
        end
        
        function draw(obj)
            % open window to draw
            if ~obj.windowOpen
                obj.inputPicture = 255 * ones(obj.pictureSize, obj.pictureSize, 'uint8');
                obj.windowOpen = true;
                figure('Name','Draw...', 'NumberTitle','off', 'Resize', 'off', 'MenuBar', 'none', 'ToolBar', 'none');
                imshow(obj.inputPicture, 'InitialMagnification','fit', 'Border','tight');
                truesize([obj.windowSize obj.windowSize]);
                set(gcf,'WindowButtonMotionFcn', @obj.mouseMoveCallBack);
                set(gcf, 'WindowButtonDownFcn',@obj.mouseDownCallBack);
                set(gcf, 'WindowButtonUpFcn',@obj.mouseUpCallBack); 
                set(gcf, 'CloseRequestFcn', @obj.onCloseRequest);
            end
        end
        
        function mouseMoveCallBack(obj, src, evt)
            %Draw if mouse is clicked
            if obj.mouseDown
                pos = get(gcf, 'Position'); %// gives x left, y bottom, width, height
                width = pos(3);
                height = pos(4);
            
                mousePos=get(src,'CurrentPoint');
                mouseX = mousePos(1);
                mouseY = mousePos(2);

                x = mouseX / width;
                y = mouseY / height;
                y = 1 - y;
                
                obj.drawOnImage(x, y);
                %disp(['x: ', num2str(x), ' y: ', num2str(y)]); 
                imshow(obj.inputPicture, 'InitialMagnification','fit', 'Border','tight');
            end
        end
        
        
        function drawOnImage(obj, x, y)
            if x < 0
                x = 0;
            end
            if x > 1
                x = 1;
            end
            if y < 0
                y = 0;
            end
            if y > 1
                y = 1;
            end 
            
            x = round(x * (obj.pictureSize-1)) + 1;
            y = round(y * (obj.pictureSize-1)) + 1;
            
            obj.inputPicture(y, x) = 1;
            
            if x < obj.pictureSize
                obj.inputPicture(y, x + 1) = 1;
            end
            if y < obj.pictureSize
                obj.inputPicture(y + 1, x) = 1;
            end
            if x > 1
                obj.inputPicture(y, x - 1) = 1;
            end
            if y > 1
                obj.inputPicture(y - 1, x) = 1;
            end
            
            
        end
        
        
        function mouseDownCallBack(obj, src, evt)
           obj.mouseDown = true; 
        end
        
        function mouseUpCallBack(obj, src, evt)
           obj.mouseDown = false; 
        end
        
        function onCloseRequest(obj, src, evt)
            obj.windowOpen = false;
            delete(gcf);
            obj.inputPicture = imcomplement(obj.inputPicture);
        end
        
        
    end
end

