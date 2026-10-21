import matplotlib.pyplot as plt
import torch
import numpy as np

def plot_filters(layer, single_channel=False, figsize=(12, 12)):
    """
    Визуализация фильтров свёрточного слоя
    """
    # Получаем веса слоя
    weights = layer.weight.data.cpu().numpy()
    
    # weights имеет форму: [out_channels, in_channels, height, width]
    out_channels, in_channels, h, w = weights.shape
    
    if single_channel:
        # Создаем сетку: строки = out_channels, столбцы = in_channels
        # squeeze=False гарантирует, что axes ВСЕГДА будет 2D массивом, 
        # даже если in_channels или out_channels равен 1
        fig, axes = plt.subplots(out_channels, in_channels, 
                                 figsize=(figsize[0], figsize[1]),
                                 squeeze=False)
        
        for out_ch in range(out_channels):
            for in_ch in range(in_channels):
                ax = axes[out_ch, in_ch]
                
                ax.imshow(weights[out_ch, in_ch], cmap='gray')
                ax.set_title(f'Out:{out_ch}, In:{in_ch}', fontsize=8)
                ax.axis('off')
    else:
        # Показываем фильтры в цветном режиме (для 3 каналов)
        n_filters = min(out_channels, 64)  # Ограничиваем количество
        cols = 8
        rows = (n_filters + cols - 1) // cols
        
        fig, axes = plt.subplots(rows, cols, figsize=(figsize[0], figsize[1]), squeeze=False)
        
        for i in range(n_filters):
            row = i // cols
            col = i % cols
            ax = axes[row, col]
            
            if in_channels == 3:
                # RGB фильтр
                filter_img = np.transpose(weights[i], (1, 2, 0))
                # Нормализуем для отображения
                filter_img = (filter_img - filter_img.min()) / (filter_img.max() - filter_img.min() + 1e-8)
            else:
                filter_img = weights[i, 0]
                filter_img = (filter_img - filter_img.min()) / (filter_img.max() - filter_img.min() + 1e-8)
            
            ax.imshow(filter_img)
            ax.set_title(f'Filter {i}', fontsize=8)
            ax.axis('off')
        
        # Скрываем пустые подграфики
        for i in range(n_filters, rows * cols):
            row = i // cols
            col = i % cols
            axes[row, col].axis('off')
    
    plt.tight_layout()
    plt.show()