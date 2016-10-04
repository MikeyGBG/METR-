%Test script for the getExtrinsics function
colorVid = videoinput('kinect', 1, 'RGB_1280x960');

%Set input settings
colorVid.FramesPerTrigger = 1;  %Only request one frame per trigger call
colorVid.TriggerRepeat = Inf;   %Tell vi object to allow inf trigger calls
triggerconfig([colorVid], 'manual');
start([colorVid]);
next = 1;

%Get an image from the RGB camera and display the XYZ and roll ptich yaw
%relative to the camera
while(next)
     trigger([colorVid]);
     [colorIm, colorTime, colorMeta] = getdata(colorVid);
     [rot, trans] = getExtrinsics(camMat, colorIm);
     RPY = tr2rpy(rot, 'deg');
     transf(1) = trans(1)*rot(1,1)+ trans(2)*rot(1,2) + trans(3)*rot(1,3);
     transf(2) = trans(1)*rot(2,1)+ trans(2)*rot(2,2) + trans(3)*rot(2,3);
     transf(3) = trans(1)*rot(3,1)+ trans(2)*rot(3,2) + trans(3)*rot(3,3);
     message = sprintf('X: %d\tY: %d\t Z: %d\n', round(transf(1)), round(transf(2)), round(transf(3)));
     message2 = sprintf('ROLL: %d\tPITCH: %d\tYAW: %d\n', round(RPY(1)), round(RPY(2)), round(RPY(3)));
     disp(message2);
     disp(message);
     next = input('next');
end
delete(colorVid);

     
     