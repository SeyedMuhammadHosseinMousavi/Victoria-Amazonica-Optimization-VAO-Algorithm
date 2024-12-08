import numpy as np
import matplotlib.pyplot as plt

# Define optimization functions
def ackley_function(x):
    a = 20
    b = 0.2
    c = 2 * np.pi
    d = len(x)
    sum1 = np.sum(x**2)
    sum2 = np.sum(np.cos(c * x))
    return -a * np.exp(-b * np.sqrt(sum1 / d)) - np.exp(sum2 / d) + a + np.exp(1)

def zakharov_function(x):
    d = len(x)
    term1 = np.sum(x**2)
    term2 = np.sum(0.5 * np.arange(1, d + 1) * x)
    return term1 + term2**2 + term2**4

def rastrigin_function(x):
    A = 10
    d = len(x)
    return A * d + np.sum(x**2 - A * np.cos(2 * np.pi * x))

def sphere_function(x):
    return np.sum(x**2)

def booth_function(x):
    x1, x2 = x[0], x[1]
    return (x1 + 2*x2 - 7)**2 + (2*x1 + x2 - 5)**2

def beale_function(x):
    x1, x2 = x[0], x[1]
    return (1.5 - x1 + x1 * x2)**2 + (2.25 - x1 + x1 * x2**2)**2 + (2.625 - x1 + x1 * x2**3)**2

# Functions dictionary
functions = {
    "Ackley": ackley_function,
    "Zakharov": zakharov_function,
    "Rastrigin": rastrigin_function,
    "Sphere": sphere_function,
    "Booth": booth_function,
    "Beale": beale_function
}

# VAO Algorithm
def VAO(CostFunction, VarMin, VarMax, nVar, MaxIt, nPop):
    global mu  # Declare 'mu' as global at the start of the function
    omega = np.random.randint(1, 4) * 0.1  # Drawback coefficient of ω
    psi = np.random.randint(1, 4) * 0.1  # Drawback coefficient of ψ
    lambda_ = np.random.randint(10, 31) * 0.10  # Intra Competition Rate of λ
    mu = 0.2  # Mutation Coefficient
    mu_damp = 0.98  # Mutation Coefficient Damping Ratio
    delta = 0.05 * (VarMax - VarMin)  # Uniform Mutation Range
    dmax = (VarMax - VarMin) * np.sqrt(nVar)

    # Initialize population
    population = []
    for _ in range(nPop):
        position = np.random.uniform(VarMin, VarMax, nVar)
        cost = CostFunction(position)
        population.append({"Position": position, "Cost": cost})
    
    # Find the best solution
    BestSol = min(population, key=lambda x: x["Cost"])
    BestCost = []

    for it in range(MaxIt):
        new_population = []
        for i in range(nPop):
            current_plant = population[i]
            new_plant = {"Cost": float("inf")}
            for j in range(nPop):
                if population[j]["Cost"] < current_plant["Cost"]:
                    rij = np.linalg.norm(current_plant["Position"] - population[j]["Position"]) / dmax
                    beta = psi * np.exp(-omega * rij**lambda_)
                    e = delta * np.random.uniform(-1, 1, nVar)
                    
                    # Generate new solution
                    new_position = (
                        current_plant["Position"]
                        + beta * np.random.rand(nVar) * (population[j]["Position"] - current_plant["Position"])
                        + mu * e
                    )
                    new_position = np.clip(new_position, VarMin, VarMax)
                    new_cost = CostFunction(new_position)

                    if new_cost <= new_plant["Cost"]:
                        new_plant["Position"] = new_position
                        new_plant["Cost"] = new_cost
                        if new_cost <= BestSol["Cost"]:
                            BestSol = new_plant

            new_population.append(new_plant)
        
        # Merge and sort population
        population += new_population
        population = sorted(population, key=lambda x: x["Cost"])[:nPop]
        
        # Store best cost
        BestCost.append(BestSol["Cost"])
        print(f"Iteration {it + 1}/{MaxIt}, Best Cost: {BestSol['Cost']:.5f}")
        
        # Damp mutation coefficient
        mu *= mu_damp

    return BestSol, BestCost

# Run VAO on multiple functions
results = {}
nVar = 20  # Number of decision variables
MaxIt = 120  # Maximum number of iterations
nPop = 20  # Population size
VarMin = -10
VarMax = 10

for name, func in functions.items():
    print(f"\nRunning VAO for {name} function...")
    if name in ["Booth", "Beale"]:  # These functions work only for 2 variables
        nVar = 2
    else:
        nVar = 20
    BestSol, BestCost = VAO(func, VarMin, VarMax, nVar, MaxIt, nPop)
    results[name] = BestCost

# Plot results in a single figure with subplots
num_functions = len(functions)
rows = 2
cols = 3

fig, axes = plt.subplots(rows, cols, figsize=(15, 10))
fig.suptitle("Best Cost Over Iterations for Different Functions", fontsize=16)

for i, (name, BestCost) in enumerate(results.items()):
    ax = axes[i // cols, i % cols]
    ax.plot(BestCost, label=name, linewidth=2)
    ax.set_title(name)
    ax.set_xlabel("Iteration")
    ax.set_ylabel("Best Cost")
    ax.grid(True)
    ax.legend()

plt.tight_layout(rect=[0, 0, 1, 0.96])  # Adjust layout to fit the title
plt.show()
