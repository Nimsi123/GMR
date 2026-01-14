# MUJOCO_GL=egl python scripts/gvhmr_to_robot.py --gvhmr_pred_file /bluesclues-data/home/pingpong-nima/robot_table_tennis/pipeline_outputs/shared/batch_clipped_long_1/65ces61EZhM_182173_182778_0_1_2_8/human_pose_tracker_only_tracknet/GENMO/hmr4d_results.pt --robot unitree_g1 --record_video --headless


MUJOCO_GL=egl python scripts/gvhmr_to_robot.py --gvhmr_pred_file /bluesclues-data/home/pingpong-nima/GMR/demo_data/tt4d_mixtape_genmo/batch_clipped_long_1_79C7Sxy0xro_102205_102710_1_9_0_4_0_genmo.pt --robot unitree_g1 --record_video --headless --save_path /bluesclues-data/home/pingpong-nima/GMR/retargeted_demo_data/tt4d_mixtape_genmo/batch_clipped_long_1_79C7Sxy0xro_102205_102710_1_9_0_4_0_genmo.pkl
