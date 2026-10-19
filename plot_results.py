import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np

# Data
corners = [
    'ff_100C_1v65', 'ff_100C_1v95', 'ff_n40C_1v56', 'ff_n40C_1v65', 
    'ff_n40C_1v76', 'ff_n40C_1v95', 'ss_100C_1v40', 'ss_100C_1v60', 
    'ss_n40C_1v28', 'ss_n40C_1v35', 'ss_n40C_1v40', 'ss_n40C_1v44', 
    'ss_n40C_1v60', 'ss_n40C_1v76', 'tt_025C_1v80', 'tt_100C_1v80'
]

# Pre-Layout Data
pre_setup  = [48.35, 48.72, 47.78, 48.10, 48.38, 48.69, 43.23, 45.51, 29.93, 36.43, 39.20, 40.81, 44.43, 46.08, 47.77, 47.86]
pre_hold   = [0.26, 0.19, 0.33, 0.27, 0.23, 0.18, 1.16, 0.80, 2.26, 1.66, 1.38, 1.21, 0.79, 0.59, 0.36, 0.37]
pre_tns    = [0.0] * 16

# Post-Layout Data
post_setup = [48.03, 48.43, 47.49, 47.82, 48.11, 48.44, 42.35, 44.88, 28.85, 35.69, 38.60, 40.27, 44.04, 45.77, 47.48, 47.50]
post_hold  = [0.30, 0.21, 0.36, 0.30, 0.25, 0.20, 1.47, 0.99, 3.00, 2.21, 1.81, 1.57, 0.99, 0.71, 0.41, 0.43]
post_tns   = [0.0] * 16

x = np.arange(len(corners))

def create_plot(data, title, ylabel, filename, color='#1f77b4', add_zones=False):
    plt.figure(figsize=(14, 6))
    plt.plot(x, data, marker='o', linestyle='-', color=color, linewidth=1.5, markersize=6)
    
    for i, v in enumerate(data):
        plt.annotate(f"{v:.2f}", (x[i], v), textcoords="offset points", xytext=(0,8), ha='center', fontsize=9, fontweight='bold', color=color)
        
    plt.title(title, fontsize=16, fontweight='bold')
    plt.xlabel('Sky130HD PVT Corner', fontsize=12, fontweight='bold')
    plt.ylabel(ylabel, fontsize=12, fontweight='bold')
    plt.xticks(x, corners, rotation=45, ha='right', fontsize=10)
    plt.grid(True, linestyle='--', alpha=0.6)
    
    if add_zones:
        plt.axvspan(-0.5, 5.5, color='lightblue', alpha=0.2)
        plt.axvspan(5.5, 13.5, color='lightsalmon', alpha=0.2)
        plt.axvspan(13.5, 15.5, color='lightgreen', alpha=0.2)
        plt.axhline(0, color='red', linestyle='--', linewidth=1)
    
    plt.tight_layout()
    plt.savefig(f'evidence/screenshots/{filename}', dpi=300)
    plt.close()
    print(f"Generated {filename}")

def create_comparison_plot(pre_data, post_data, title, ylabel, filename):
    plt.figure(figsize=(14, 6))
    plt.plot(x, pre_data, marker='s', linestyle='--', color='#1f77b4', label='Pre-Layout', linewidth=1.5)
    plt.plot(x, post_data, marker='o', linestyle='-', color='#d62728', label='Post-Layout', linewidth=1.5)
    
    for i in range(len(x)):
        plt.annotate(f"{pre_data[i]:.2f}", (x[i]-0.1, pre_data[i]), textcoords="offset points", xytext=(0,8), ha='center', fontsize=8, color='#1f77b4')
        plt.annotate(f"{post_data[i]:.2f}", (x[i]+0.1, post_data[i]), textcoords="offset points", xytext=(0,-14), ha='center', fontsize=8, color='#d62728')

    plt.title(title, fontsize=16, fontweight='bold')
    plt.xlabel('Sky130HD PVT Corner', fontsize=12, fontweight='bold')
    plt.ylabel(ylabel, fontsize=12, fontweight='bold')
    plt.xticks(x, corners, rotation=45, ha='right', fontsize=10)
    plt.grid(True, linestyle='--', alpha=0.6)
    plt.legend(loc='lower left')
    plt.tight_layout()
    plt.savefig(f'evidence/screenshots/{filename}', dpi=300)
    plt.close()
    print(f"Generated {filename}")

# --- 5 POST-LAYOUT GRAPHS ---
create_plot(post_setup, 'Post-Layout Setup WNS for Each Sky130HD Corner', 'Setup WNS (ns)', 'G7_post_setup_wns.png', '#1f77b4')
create_plot(post_hold, 'Post-Layout Hold WNS for Each Sky130HD Corner', 'Hold WNS (ns)', 'G8_post_hold_wns.png', '#ff7f0e')
create_plot(post_tns, 'Post-Layout Setup TNS for Each Sky130HD Corner', 'Setup TNS (ns)', 'G9_post_setup_tns.png', '#2ca02c')
create_plot(post_tns, 'Post-Layout Hold TNS for Each Sky130HD Corner', 'Hold TNS (ns)', 'G15_post_hold_tns.png', '#d62728')
create_plot(post_setup, 'Post-Layout Setup WS for Each Sky130HD Corner', 'Setup WS (ns)', 'G16_post_setup_ws.png', '#1f77b4', add_zones=True)

# --- 5 PRE-LAYOUT GRAPHS ---
create_plot(pre_setup, 'Pre-Layout Setup WNS for Each Sky130HD Corner', 'Setup WNS (ns)', 'G12_pre_setup_wns.png', '#2ca02c')
create_plot(pre_hold, 'Pre-Layout Hold WNS for Each Sky130HD Corner', 'Hold WNS (ns)', 'G13_pre_hold_wns.png', '#9467bd')
create_plot(pre_tns, 'Pre-Layout Setup TNS for Each Sky130HD Corner', 'Setup TNS (ns)', 'G14_pre_setup_tns.png', '#e377c2')
create_plot(pre_tns, 'Pre-Layout Hold TNS for Each Sky130HD Corner', 'Hold TNS (ns)', 'G17_pre_hold_tns.png', '#8c564b')
create_plot(pre_setup, 'Pre-Layout Setup WS for Each Sky130HD Corner', 'Setup WS (ns)', 'G18_pre_setup_ws.png', '#2ca02c', add_zones=True)

# --- 2 COMPARISON GRAPHS ---
create_comparison_plot(pre_setup, post_setup, 'Setup WNS: Pre-Layout vs Post-Layout', 'Setup WNS (ns)', 'G10_pre_vs_post_setup.png')
create_comparison_plot(pre_hold, post_hold, 'Hold WNS: Pre-Layout vs Post-Layout', 'Hold WNS (ns)', 'G11_pre_vs_post_hold.png')

print("\nAll 12 graphs successfully saved to evidence/screenshots/")
