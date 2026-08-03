# Inverted Pendulum State-Space Representation Reference

This document serves as a mathematical reference for the inverted pendulum on a cart (cart-pole) system, outlining the equations of motion, linearization, and the resulting state-space representation.

---

## 1. System Parameters and States

### Physical Parameters
*   $M$: Mass of the cart ($kg$)
*   $m$: Mass of the pendulum bob ($kg$)
*   $l$: Length from pivot to the pendulum's center of mass ($m$)
*   $I$: Moment of inertia of the pendulum about its center of mass ($kg \cdot m^2$)
*   $b$: Viscous friction coefficient of the cart ($N \cdot s / m$)
*   $g$: Acceleration due to gravity ($9.81 \, m/s^2$)
*   $u$ (or $F$): Control force applied to the cart ($N$)

### State Vector
The system is represented by four state variables:
$$\mathbf{x} = \begin{bmatrix} x_1 \\ x_2 \\ x_3 \\ x_4 \end{bmatrix} = \begin{bmatrix} x \\ \dot{x} \\ \theta \\ \dot{\theta} \end{bmatrix}$$

*   $x$: Cart position ($m$)
*   $\dot{x}$: Cart velocity ($m/s$)
*   $\theta$: Pendulum angle ($rad$), defined as $0$ when upright (vertical) and positive counter-clockwise
*   $\dot{\theta}$: Pendulum angular velocity ($rad/s$)

---

## 2. Equations of Motion (Nonlinear)

Using Lagrangian mechanics, the two coupled, nonlinear second-order differential equations governing the system dynamics are:

1.  **Cart Dynamics:**
    $$(M + m)\ddot{x} + b\dot{x} - ml\ddot{\theta}\cos\theta + ml\dot{\theta}^2\sin\theta = F$$

2.  **Pendulum Dynamics:**
    $$(I + ml^2)\ddot{\theta} - mgl\sin\theta - ml\ddot{x}\cos\theta = 0$$

---

## 3. Linearization

To stabilize the pendulum around its upright unstable equilibrium point ($\theta = 0$), we linearize the equations assuming small deviations ($\theta \approx 0$):
*   $\sin\theta \approx \theta$
*   $\cos\theta \approx 1$
*   $\dot{\theta}^2 \approx 0$ (neglect higher-order terms)

Substituting these approximations yields the **linearized equations of motion**:
1.  $(M + m)\ddot{x} + b\dot{x} - ml\ddot{\theta} = F$
2.  $(I + ml^2)\ddot{\theta} - mgl\theta - ml\ddot{x} = 0$

---

## 4. State-Space Representation

Solving the linearized equations for the accelerations $\ddot{x}$ and $\ddot{\theta}$ yields the standard state-space form:
$$\dot{\mathbf{x}} = A\mathbf{x} + Bu$$
$$\mathbf{y} = C\mathbf{x} + Du$$

### General Case (with Pendulum Inertia $I$)

Let the common denominator term be:
$$q = I(M + m) + M m l^2$$

The state matrix $A$ and input matrix $B$ are:
$$A = \begin{bmatrix} 
0 & 1 & 0 & 0 \\ 
0 & \frac{-(I + ml^2)b}{q} & \frac{m^2 g l^2}{q} & 0 \\ 
0 & 0 & 0 & 1 \\ 
0 & \frac{-m l b}{q} & \frac{m g l (M + m)}{q} & 0 
\end{bmatrix}, \quad 
B = \begin{bmatrix} 
0 \\ 
\frac{I + ml^2}{q} \\ 
0 \\ 
\frac{ml}{q} 
\end{bmatrix}$$

---

### Simplified Point-Mass Case ($I = 0$)

If the pendulum is modeled as a point mass at the end of a massless rod (meaning $I = 0$), the equations simplify significantly:
$$A = \begin{bmatrix} 
0 & 1 & 0 & 0 \\ 
0 & -\frac{b}{M} & \frac{mg}{M} & 0 \\ 
0 & 0 & 0 & 1 \\ 
0 & -\frac{b}{Ml} & \frac{g(M+m)}{Ml} & 0 
\end{bmatrix}, \quad 
B = \begin{bmatrix} 
0 \\ 
\frac{1}{M} \\ 
0 \\ 
\frac{1}{Ml} 
\end{bmatrix}$$

---

### Output Matrix $C$ and Direct Transmission Matrix $D$

According to the system's measurements configuration (e.g., as noted in the block diagram [Wirkungsplan-v1.excalidraw.md](file:///c:/repos/inverted-pendulum-ees/Excalidraw/Wirkungsplan-v1.excalidraw.md)):

*   **Case 1: Full State Feedback** (all states are directly measured)
    $$C = \begin{bmatrix} 1 & 0 & 0 & 0 \\ 0 & 1 & 0 & 0 \\ 0 & 0 & 1 & 0 \\ 0 & 0 & 0 & 1 \end{bmatrix}, \quad D = \begin{bmatrix} 0 \\ 0 \\ 0 \\ 0 \end{bmatrix}$$

*   **Case 2: Standard Measured Outputs** (measuring only cart position $x$ and pendulum angle $\theta$)
    $$C = \begin{bmatrix} 1 & 0 & 0 & 0 \\ 0 & 0 & 1 & 0 \end{bmatrix}, \quad D = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$$
    > [!NOTE]
    > In this layout, velocity states ($\dot{x}$ and $\dot{\theta}$) must be estimated using an observer (e.g., a Kalman Filter or Luenberger Observer) to implement full-state control architectures like LQR.

---

## 5. Curated Online Resources

Here are the highest-quality online resources for understanding the modeling, analysis, and control design of this system:

1.  **[Control Tutorials for MATLAB & Simulink (CTMS) - Inverted Pendulum Modeling](https://control.che.upenn.edu/ot/ctms/matlab/index0722.html?example=InvertedPendulum&section=SystemModeling)**
    *   *Why it's great:* The absolute gold-standard tutorial for this system. It includes physical free-body diagrams, step-by-step Newtonian derivations, and MATLAB code to build the linear state-space object.
    *   *Control Design Follow-ups:*
        *   [CTMS State-Space Control Design (LQR)](https://control.che.upenn.edu/ot/ctms/matlab/indexaa68.html?example=InvertedPendulum&section=StateSpace)
        *   [CTMS PID Controller Design](https://control.che.upenn.edu/ot/ctms/matlab/indexa145.html?example=InvertedPendulum&section=PID)

2.  **[MathWorks - Control of an Inverted Pendulum on a Cart](https://www.mathworks.com/help/control/ug/control-of-an-inverted-pendulum-on-a-cart.html)**
    *   *Why it's great:* Practical MATLAB/Simulink walkthrough demonstrating how to linearize a nonlinear Simulink model and design an LQR controller to balance the pendulum.

3.  **[Steve Brunton (Control Bootcamp) - Inverted Pendulum on a Cart (YouTube)](https://www.youtube.com/watch?v=qjhAAQexzLg)**
    *   *Why it's great:* A fantastic, intuitive video explanation of the physics, Lagrangian derivation, linearization, and controllability checks for the cart-pole system.
