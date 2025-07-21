#!/bin/bash
# Claude Ubuntu Sandbox Startup Script
# This script initializes the Ubuntu sandbox environment for Claude

set -e

# Log function for better visibility
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
    }

    # Create necessary directories if they don't exist
    create_directories() {
        log "Creating necessary directories..."
            mkdir -p $HOME/logs
                mkdir -p $HOME/data
                    mkdir -p $HOME/projects
                        mkdir -p $HOME/mcp/db
                        }

                        # Start VNC server
                        start_vnc() {
                            log "Starting VNC server..."
                                vncserver :1 -geometry $VNC_RESOLUTION -depth 24 -dpi $VNC_DPI
                                    log "VNC server started on port 5901"
                                    }

                                    # Start noVNC web interface
                                    start_novnc() {
                                        log "Starting noVNC web interface..."
                                            websockify -D --web=/usr/share/novnc/ 6080 localhost:5901
                                                log "noVNC web interface started on port 6080"
                                                }

                                                # Start MCP server for memory persistence
                                                start_mcp() {
                                                    log "Starting MCP (Memory Persistence) server..."
                                                        cd $HOME/mcp
                                                            python3 mcp_server.py > $HOME/logs/mcp.log 2>&1 &
                                                                log "MCP server started on port 8080"
                                                                }

                                                                # Start Claude API integration service
                                                                start_claude_integration() {
                                                                    log "Starting Claude API integration service..."
                                                                        cd $HOME/scripts
                                                                            python3 claude_integration.py > $HOME/logs/claude_integration.log 2>&1 &
                                                                                log "Claude integration service started on port 8888"
                                                                                }

                                                                                # Main function
                                                                                main() {
                                                                                    log "Starting Claude Ubuntu Sandbox environment..."

                                                                                            # Create necessary directories
                                                                                                create_directories
                                                                                                    
                                                                                                        # Start VNC server
                                                                                                            start_vnc
                                                                                                                
                                                                                                                    # Start noVNC web interface
                                                                                                                        start_novnc
                                                                                                                            
                                                                                                                                # Start MCP server
                                                                                                                                    start_mcp
                                                                                                                                        
                                                                                                                                            # Start Claude integration service
                                                                                                                                                start_claude_integration
                                                                                                                                                    
                                                                                                                                                        log "Claude Ubuntu Sandbox environment started successfully!"
                                                                                                                                                            log "Access via:"
                                                                                                                                                                log "- VNC client: localhost:5901"
                                                                                                                                                                    log "- Web browser: http://localhost:6080/vnc.html"
                                                                                                                                                                        log "- MCP API: http://localhost:8080"
                                                                                                                                                                            log "- Claude API: http://localhost:8888"
                                                                                                                                                                                
                                                                                                                                                                                    # Keep the container running
                                                                                                                                                                                        tail -f $HOME/logs/mcp.log
                                                                                                                                                                                        }
                                                                                                                                                                                        
                                                                                                                                                                                        # Execute main function
                                                                                                                                                                                        main
