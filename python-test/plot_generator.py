import tkinter
import matplotlib
import matplotlib.pyplot as plt
import numpy as np

matplotlib.use('TkAgg')

def display_plot():
    # Random data for box plot
    data = np.random.rand(10, 5)

    plt.boxplot(data)
    plt.title('Simple Box Plot')
    plt.ylabel('Values')
    plt.xlabel('Categories')

    # Display the plot
    plt.show()

if __name__ == "__main__":
    display_plot()

