import numpy as np
import matplotlib.pyplot as plt

rng = np.random.default_rng(5014) # set a seed for reproducible figures

## simulate a simple linear relationship: y = 2 + 0.5 x + noise
n = 60
x = rng.uniform(0, 10, size=n)
y = 2 + 0.5 * x + rng.normal(0, 1, size=n)

## ordinary least squares fit
X = np.column_stack([np.ones(n), x])
beta = np.linalg.solve(X.T @ X, X.T @ y) # (X'X)^{-1} X'y
fitted = X @ beta
resid = y - fitted

## panel (a): data and fitted line
xx = np.linspace(0, 10, 100)
fig, ax = plt.subplots(figsize=(4, 3))
ax.scatter(x, y, s=22, alpha=0.7, edgecolor="none", label="data")
ax.plot(xx, beta[0] + beta[1] * xx, lw=2,
        label=f"OLS fit: $\\hat y = {beta[0]:.2f} + {beta[1]:.2f}x$")
ax.set_xlabel("$x$")
ax.set_ylabel("$y$")
ax.legend(frameon=False, fontsize=8)
fig.tight_layout()
fig.savefig("figures/scatter.pdf") # vector PDFs look crisp at any size

## panel (b): residual diagnostic
fig, ax = plt.subplots(figsize=(4, 3))
ax.scatter(fitted, resid, s=22, alpha=0.7, edgecolor="none")
ax.axhline(0, lw=1, ls="--", color="0.4")
ax.set_xlabel("fitted values")
ax.set_ylabel("residuals")
fig.tight_layout()
fig.savefig("figures/residuals.pdf")

print("wrote figures/scatter.pdf and figures/residuals.pdf")