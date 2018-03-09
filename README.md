# matlab-robotics-modeling
Initialize class robot with properties of your robot. See "mearm.m" or "testbot.m"
for examples of robot properties. 


Each robot has the following properties:

Links: xyz location of the vertices of each link on the robot

constraints: Struct with the following attributes
    type - the type of connection constraint ("fixed", "fourbar", and "extension")
        fixed - the vector between the forcing point and all constrained points is constant.
        fourbar - The four vertices follow parallelogram constraints for a fourbar linkage.
        extension - The reference point is fixed acording to the joint axis

    forced - Reference point
    joints - joints for constraint to be applied onto

aesthetics: Connectivity diagram for plotting. each separate part of the bot should be separated by a comma

dof: Degrees of freedom of each joint.
    dof must be a cell of dimensions nx1, where n is the number of joints in the system.
    The first input to each cell is a string with the co-ordinate of motion, followed by the number degree of freedom that actuation is.
    Example: joint 5 is actuated about the y axis:
        dof{5} = {'thy', 1}
    If a joint has multiple degrees of freedom:
        dof{i} = {'dof1', deg1, 'dof2', deg2, ..., 'dofn', degn}




Initialize robot class as follows:

myrobot = robot(rprops()) , where rprops is a target function that assigns the properties shown above.
From there, there are two basic commands:

myrobot.move(in1, in2, ..., inN), where each in is the input to the specified actuator

myrobot.show(), plots the configuration of your robot.
There are a number of attributes inside the robot class, type "help robot" for more information.



